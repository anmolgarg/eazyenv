#!/bin/bash
# run like bash start-lab.sh PORT HASHED_PASSWORD

# arg 1 is port. if not given, port=8888
PORT=$1
if [ "$PORT" == "" ]; then
	PORT=8888
fi
# arg 2 is password. if not given, password=default password
__password=$2

# set variables
VOLUME=${PWD##*/}
CONTAINERNAME=$VOLUME"-LAB-"$PORT
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
# https://github.com/jupyter/docker-stacks/tree/master/pyspark-notebook
IMAGE="jupyter/pyspark-notebook"

# try to stop and remove container if already exists
docker stop $CONTAINERNAME
docker rm $CONTAINERNAME

# docker run [options] image [command]
docker run \
	--restart unless-stopped \
	--name $CONTAINERNAME \
	-dt -u 0 \
	--net=host \
	-p $PORT:$PORT \
	-e SPARK_LOCAL_IP=$HOST_IP \
	-v $(pwd):/home/$VOLUME \
	-v $(pwd)/jovyan/airflow:/home/jovyan/airflow \
	-w /home/$VOLUME \
	$IMAGE \
	/bin/bash

# install requirements and wait for conda to finish updating
docker exec -d $CONTAINERNAME bash scripts/install_requirements.sh
sleep 240
# set password
docker exec -d $CONTAINERNAME bash scripts/set_password.sh $__password
# start lab server
docker exec -d $CONTAINERNAME bash scripts/start_lab_server.sh $PORT

echo "Your jupyter-lab is now running at: http://"$HOST_IP":"$PORT"/lab"

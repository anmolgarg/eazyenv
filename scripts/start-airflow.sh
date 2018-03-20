#!/bin/bash
# run like bash start-airflow.sh CONTAINERNAME PORT

# arg 1 is container name
CONTAINERNAME=$1

# arg 2 is port. if not given, port=8889
PORT=$2
if [ "$PORT" == "" ]; then
	PORT=8889
fi

# start airflow server in given container
docker exec \
	-d $CONTAINERNAME \
	bash start_airflow_server.sh $PORT


# set variables for mocktainer
MOCKCONTAINERNAME=${CONTAINERNAME:0:6}"-AF-"$PORT
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

# try to stop and remove mock container if already exists
docker stop $MOCKCONTAINERNAME
docker rm $MOCKCONTAINERNAME

# start mocktainer to note airflow port
docker run \
	--name $MOCKCONTAINERNAME \
	-dt  \
	busybox \
	sh

echo "In a few moments, your airflow server will be running at: http://"$HOST_IP":"$PORT

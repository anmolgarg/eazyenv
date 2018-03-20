#!/bin/bash
# run like bash start-file-server.sh PORT

# arg 1 is port. if not given, port=8890
PORT=$1
if [ "$PORT" == "" ]; then
	PORT=8890
fi

# set variables
VOLUME=${PWD##*/}
CONTAINERNAME=$VOLUME"-FS-"$PORT
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

# try to stop and remove container if already exists
docker stop $CONTAINERNAME
docker rm $CONTAINERNAME

# run image at given port, mounting current wd
docker run \
	--name $CONTAINERNAME \
	-d  \
	-p $PORT:80 \
	-v `pwd`:/var/www \
	yowmamasita/h5ai

echo "Your file server is now running at: http://"$HOST_IP":"$PORT
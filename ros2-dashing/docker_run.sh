#!/bin/bash

image="ibisssl/ros2-dashing"
container="ros2-dashing"

if [ "$DOCKER_ROS_IP" == "" ]; then
    export DOCKER_ROS_IP=localhost
fi

xhost +si:localuser:root

# if ${container_name} exists
docker rm ${container}

EXE=${@:-"/bin/bash"}

docker run --rm -it \
    --privileged \
    --gpus=all \
    --net=host \
    --env=DOCKER_ROS_IP \
    --env=DOCKER_ROS_MASTER_URI \
    --env=DOCKER_ROS_SETUP \
    --env=DISPLAY \
    --env=QT_X11_NO_MITSHM=1 \
    --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
    --name=${container} \
    --volume=${PROG_DIR:-$(pwd)}:/userdir \
    -w=/userdir \
    ${image} ${EXE}

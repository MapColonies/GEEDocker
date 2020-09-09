#!/bin/bash

VOLUME_CONNECT="/gevol/server:/gevol/server"
STORAGE_MOUNT="source=gee-server-storage,target=/var/opt/google/pgsql/data"

# Default values of arguments
ENTERYPOINT=0

# Loop through arguments and process them
# Taken from: https://pretzelhands.com/posts/command-line-flags
for arg in "$@"
do
    case $arg in
        --entrypoint)
        ENTERYPOINT=1
        shift # Remove
        ;;
    esac
done
#--mount $STORAGE_MOUNT
if [ $ENTERYPOINT -eq 1 ]; then
    docker run --rm -it \
        -h WW-PC:8081 \
        --privileged \
        --entrypoint /bin/bash \
        -v $VOLUME_CONNECT \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v ~/.ssh:/root/.ssh \
        --name servercontainer \
        -p 8081:80 \
        geeserver-ssh:v1
else
    docker run --rm \
        -h WW-PC:8081 \
        --privileged \
        -v $VOLUME_CONNECT \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v ~/.ssh:/root/.ssh \
        --name servercontainer \
        -p 8081:80 \
        geeserver-ssh:v1 &
fi

#!/bin/bash

docker build --rm -t geefusion:v1 -f Dockerfile .

# Remove all <None> images (dangling)
docker rmi $(docker images --filter "dangling=true" -q)

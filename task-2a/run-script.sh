#!/bin/bash

# create image
docker build -t my-image -f ./Dockerfile .
export IMAGE_TS=$(date +%Y%m%d%H%M%S)



# create container from image
docker container run -dit -p 80:80 --name my-container my-image





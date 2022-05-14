#!/bin/bash

# create image
docker build -t my-image -f ./Dockerfile .
#image_timestamp=$(date +%d-%m-%Y_%H-%M-%S)
#echo $image_timestamp > image_timestamp

# create container from image
docker container run -dit -p 80:80 --name my-container my-image





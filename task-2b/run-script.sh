#!/bin/bash

#1-Download the latest release with the command
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

#2-Make the kubectl binary executable:
sudo chmod +x ./kubectl

#3-Move the binary in to your PATH:
sudo mv ./kubectl /usr/local/bin/kubectl

#4-Test to ensure the version you installed is up-to-date:
sudo kubectl version --client

#5-Docker install:
sudo apt-get install -y docker.io

#6-Minikube install:
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

#7-Minikube version:
sudo minikube version

#8-Start minikube:
sudo -i
sudo minikube start --driver=none

#9-Install the conntrack:
sudo apt install conntrack

#10-Start again minikube:
sudo minikube start --driver=none

#11-minikube status
sudo minikube status

#12-Check the minikube using kubectl:
sudo kubectl get pods
sudo kubectl get svc

#13 Create docker image
sudo docker build -t my-image -f ./Dockerfile .
export IMAGE_TS=$(date +%Y%m%d%H%M%S)

#14-Use the kubectl create command to create a Deployment that manages a Pod.The Pod runs a Container based on the provided Docker image:

sudo kubectl create deployment hello-node --image=my-image
export DEPLOY_TS=$(date +%Y%m%d%H%M%S)

#15-To make the hello-node Container accessible from outside:
sudo kubectl expose deployment hello-node --type=NodePort --port=8080
kubectl get svc
minikube service hello-node
#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="wasupont/udapredict"

# Step 2
# Run the Docker Hub container with kubernetes
minikube kubectl -- create deployment udapredict-container --image=docker.io/wasupont/udapredict

# Step 3:
# List kubernetes pods
minikube kubectl -- get pods
export POD_NAME=$(minikube kubectl -- get pods -o=name)
echo $POD_NAME

# Step 4:
# Forward the container port to a host
minikube kubectl -- expose deployment/udapredict-container --type="NodePort" --port 8000
minikube kubectl -- port-forward $POD_NAME 8000:80

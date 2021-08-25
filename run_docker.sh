#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build --tag udapredict .

# Step 2: 
# List docker images
docker images -a

# Step 3: 
# Run flask app
docker run -d --rm -p 8000:80 --name udapredict-container udapredict python app.py

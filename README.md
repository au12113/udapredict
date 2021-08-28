[![CircleCI](https://circleci.com/gh/au12113/udapredict.svg?style=svg)](https://circleci.com/gh/au12113/udapredict)

## Project Overview

In this project, you will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API. 

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:
* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---

## Setup the Environment

* Create a virtualenv and activate it
  * Create a virtual environment: `python -m venv ~/<environment_name>`
  * Activate the virtual environment: `source ~/<environment_name>/activate`
* Run `make install` to install the necessary dependencies
* Run `make lint` to linting app.py with pylint and Dockerfile with hadolint
* [ Recommend ] Windows users install Chocolatey following the instructions, [on Chocolatey's page](https://chocolatey.org/install)

### Running `app.py`

1. Standalone:  `python app.py`
   In case of error when running on port 80: `sudo python app.py`
2. Build image and run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  
   1. Upload recent image: `./upload_docker.sh`
   2. Get latest version and run in Kubernetes: `./run_kubernetes.sh`

### Kubernetes Steps

* Setup and Configure Docker locally
  * Linux :
    * Get Docker repository
    ```
        $ sudo apt-get update
        $ sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
        $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        $ echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```
    * Install Docker Engine
    ```
        $ sudo apt-get update
        $ sudo apt-get install docker-ce docker-ce-cli containerd.io
    ```
  * Windows : 
    * [Docker Desktop](https://www.docker.com/products/docker-desktop)
* Setup and Configure Kubernetes locally
  * Install kubectl 
    * Linux
      * Get repository and install 
      ```
        $ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        $ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
      ```
      * Test to ensure the version of kubectl 
      ```
        $ kubectl version --client
      ```
    * Windows
      ```
      choco install kubernetes-cli
      ```

  * Install minikube
    * Linux
      ```
      $ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
      $ sudo install minikube-linux-amd64 /usr/local/bin/minikube
      ```
    * Windows
        ```choco install minikube```
* Build Flask app to Docker image and upload to Docker Hub
  ```
  $ docker build --tag udapredict .
  $ ./upload_docker.sh
  ```
* Run via kubectl
  ```
  $ minikube start
  $ ./run_kubernetes.sh
  ```
  ```
  (run prediction on separate terminal)
  $ ./make_prediction.sh
  ```

### Project structure
```
.
|-- app.py
|-- Makefile 
|-- requirements.txt : required python library that apply in Makefile
|-- Dockerfile
|-- run_docker.sh 
|-- make_prediction.sh : script to request prediction 
|-- run_kubernetes.sh : change docker path to your own
|-- upload_docker.sh : change docker path and authentication to your own 
|-- .circleci
|   |-- config.yml
|
|-- model_data
|   |-- boston_housing_prediction.joblib : pretrained model
|   |-- housing.csv
|
|-- output_txt_files: directory to collect log
    |-- docker_out.txt
    |-- kubernetes_out.txt
```
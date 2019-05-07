---
tech: docker
title: Getting started
---

## Ubuntu installation

Follow steps defined in <https://docs.docker.com/install/linux/docker-ce/ubuntu/>:

```sh
# Update
sudo apt-get update

# use apt over HTTPS
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Docker key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Search for key
sudo apt-key fingerprint 0EBFCD88

# Install stable version
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## First container

Hello world is:

```sh
sudo docker run helloworld
```

Images needs to be pulled before creating a container:

```sh
# Search image 
sudo docker search ubuntu

# Fetch an image
sudo docker pull ubuntu

# List all containers
sudo docker ps -a

# Create an interactive container
sudo docker run -it --name mycontainer ubuntu

# Exit the current container via "exit" or
sudo docker stop mycontainer

# Start again
sudo docker start -i mycontainer
```

For more detail regarding configuration, what to install and such, check the corresponding OS


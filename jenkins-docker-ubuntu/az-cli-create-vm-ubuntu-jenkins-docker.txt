#!/bin/bash

# Create a resource group.
az group create --name my-resource-group --location southcentralus

# Create a new virtual machine, this creates SSH keys if not present.
az vm create --resource-group my-resource-group --name jenkins-docker-ubuntu --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

# Open port 80 to allow web traffic to host.
az vm open-port --port 80 --resource-group my-resource-group --name jenkins-docker-ubuntu
az vm open-port --port 8080 --resource-group my-resource-group --name jenkins-docker-ubuntu

# Start a CustomScript extension to use a simple bash script to update, download and install WordPress and MySQL 
az vm extension set \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --name CustomScript \
    --vm-name jenkins-docker-ubuntu \
    --resource-group my-resource-group \
    --settings '{"fileUris":["https://raw.githubusercontent.com/dudick123/azure-dev/master/jenkins-docker-ubuntu/install-jenkins-docker.sh"],"commandToExecute":"sh install-jenkins-docker.sh"}'

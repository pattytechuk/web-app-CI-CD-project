Project Report: Deploying a Containerized Web Application with Azure DevOps CI/CD Pipeline and Kubernetes

## Overview

This project demonstrates my ability to set up a complete CI/CD pipeline for a web application using various tools and technologies. The purpose is to develop skills in cloud infrastructure deployment, automation/scripting, and Kubernetes management.

## Project Structure
The following is the folder structure for this project. 
```
web-app-CI-CD-project/
│
├── bicep/              # Bicep templates for infrastructure as code (IaC)
├── ci-cd/              # CI/CD pipeline configurations (YAML files, scripts, etc.)
├── documents/          # Documentation files (this file is located here)
├── k8s-manifests/      # Kubernetes manifests for deploying the application
├── images/             # Screenshots, images, diagrams
- README.md                  # Overview of project
- .gitignore                 # Ignore unnecessary files
```

## Tools & Technologies Used

GitHub & Git: Version control and repository management.

Bicep: Infrastructure as Code (IaC) tool for Azure resources.

Azure DevOps: For automated deployment of CI/CD pipeline.

Kubernetes: Deployment and management of containerized applications.

## Planning and Preparation

**Goal Setting and Requirements:** My goal was to containerize a web application and automate its deployment using Azure Kubernetes Services (AKS). For the first part of the project, I manually set up the infrastructure using Bicep, set up an AKS cluster, deploy the web app into the cluster, and then verify the web application's functionality. 

For the second part of the project, I set up a pipeline in Azure DevOps' pipelines in order to automate the deployment of the infrastructure, AKS cluster, and the deployment of the web application. 

**Set Up Development Environment:** The following are the tools and resources I set up at the beginning:
- Installed Git.
- Installed Docker.
- Installed extensions for Visual Studio Code including Azure CLI Tools, Azure Tools, Bicep for VS Code, Docker for VS Code, and YAML.
- Set up Azure DevOps account and created a project; also created pipeline.
- Set up Azure CLI for Azure interaction.

**Application Details:** I chose a sample web app using Express/Node Js available for use on on Awesome Compose's Github repo: https://github.com/docker/awesome-compose/tree/master


## Steps Taken

1. Cloned Repository with Web App  

    Cloned the repository locally using: 

    `git clone https://github.com/docker/awesome-compose/tree/master/react-express-mongodb`  

2. Ran Web App Locally

    Opened the integrated terminal in Visual Studio Code  

    Navigated to the project directory using:  
    `cd awesome-compose/react-express-mongoDB`  

    Authenticated into my Docker account:  
    `docker login`  

    Ran the Docker command to start the multi-container app:  
    `docker-compose up -d`  

    After starting the app with Docker, opened browser to check at http://localhost:3000 to view the app:  
    [screenshot1]  

    Read through Dockerfile included in the app.  

3.  Created resources for the project using Azure CLI  

    Logged into Azure account:  
    `az login`

    Created resource group for the web app and AKS cluster:  
    `az group create --name webapp1 --location UKSouth`  

    Created Azure Container Registry (ACR):     
    `az acr create --resource-group webapp1 --name webappcr1 --sku Basic`  

    [screenshot2]  
    Above: Resource group created to contain web app and AKS cluster.  
    [screenshot3]  
    Above: Azure Container Registry 'webappcr1' in the Azure portal.

4.  Tagging and creating container images to push to ACR

    Logged into ACR:  
    `az acr login --name webappcr1`  

    The web application is structured into three components: the frontend, backend, and MongoDB database. To enable isolated and scalable deployment, I created three separate container images—one for each component:  
    `docker tag react-express-mongodb-frontend webappcr1.azurecr.io/mywebapp-frontend:latest`  

    `docker tag react-express-mongodb-backend webappcr1.azurecr.io/mywebapp-backend:latest`  

    `docker tag mongo webappcr1.azurecr.io/webapp-mongo:4.2.0`  

    Verified pushed images:  
    `az acr repository list --name webappcr1 --output table`  
    [screenshot4] 
    Above: Output showing all tagged images.  
    [screenshot5]  
    Above: Container registry images in the Azure portal.

5.  Deployed Bicep template with Infrastructure  

    Created main2.bicep to define Azure Kubernetes Services (including cluster), Azure Container Registry, and Virtual Network:  
    `az deployment group create --resource-group webapp1 --template-file main2.bicep`  
    (Please refer to folder 'bicep' to see the template deployed.)  
    [screenshot6]  
    [screenshot7]  
    [screenshot8]

10. Creating the GitHub Repository  

    Created a new repository on GitHub named web-app-CI-CD-project.  

    Cloned the repository locally using:  

    `git clone https://github.com/pattytechuk/web-app-CI-CD-project.git`  


11. Initializing the Project  

    Created folders: bicep/, ci-cd/, documents/, images/ and k8s-manifests/.  

    Initialized a Git repository:  
    `git init`  

    Set remote origin:  
    `git remote add origin https://github.com/pattytechuk/web-app-CI-CD-project.git`  


12. Pushing to GitHub  

    Staged all files and committed changes:  

    `git add .`  
    `git commit -m "Initial project structure setup"`  

    Pushed to GitHub:  
    `git push -u origin main`  

## Reflection  

(Discuss challenges faced, what you learned, and areas to improve.)  
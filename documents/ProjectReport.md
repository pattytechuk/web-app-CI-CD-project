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
    ![screenshot1](https://github.com/user-attachments/assets/90e5e9f6-5927-4682-8f2d-bb295c8dc515)

    Above: Verifying local web application setup; running on localhost: 3000. 

    Read through Dockerfile included in the app.  

3.  Created resources for the project using Azure CLI  

    Logged into Azure account:  
    `az login`

    Created resource group for the web app and AKS cluster:  
    `az group create --name webapp1 --location UKSouth`  

    Created Azure Container Registry (ACR):     
    `az acr create --resource-group webapp1 --name webappcr1 --sku Basic`  

    ![screenshot2 resource group](https://github.com/user-attachments/assets/872e07b7-1573-4675-a6d3-3f08cceb22cb)
    Above: Resource group created to contain web app and AKS cluster.  
      
    ![screenshot3 webappcr1](https://github.com/user-attachments/assets/85b9f3d3-c1d7-4904-8347-d1046776eb56)
    Above: Azure Container Registry 'webappcr1' in the Azure portal.  

5.  Tagging and creating container images to push to ACR

    Logged into ACR:  
    `az acr login --name webappcr1`  

    The web application is structured into three components: the frontend, backend, and MongoDB database. To enable isolated and scalable deployment, I created three separate container images—one for each component:  
    `docker tag react-express-mongodb-frontend webappcr1.azurecr.io/mywebapp-frontend:latest`  

    `docker tag react-express-mongodb-backend webappcr1.azurecr.io/mywebapp-backend:latest`  

    `docker tag mongo webappcr1.azurecr.io/webapp-mongo:4.2.0`  

    Verified pushed images:  
    `az acr repository list --name webappcr1 --output table`  
    
    ![screenshot4](https://github.com/user-attachments/assets/a116bc4c-eead-46a8-b586-f77ca7b5fa07)  
    Above: Output showing all tagged images.  
    
    ![screenshot5](https://github.com/user-attachments/assets/80ebccdd-7e1e-4bd6-86cd-8dcac1441172)  
    Above: Container registry images in the Azure portal.  

7.  Deployed Bicep template with Infrastructure  

    Created main2.bicep to define Azure Kubernetes Services (including cluster), Azure Container Registry, and Virtual Network:  
    `az deployment group create --resource-group webapp1 --template-file main2.bicep`  
    (Please refer to folder 'bicep' to see the template deployed.)  

    ![screenshot 6 bicep file output](https://github.com/user-attachments/assets/d2d88814-8685-4951-9f09-f6f50206cda1)  
    Above: Output showing successful deployment of Bicep file.
    
    ![screenshot7](https://github.com/user-attachments/assets/6f9be9fc-06c2-4184-a8e3-287b791bec4c)  
    Above: Resource group (webapp1) with newly deployed AKS cluster (myAKScluster), virtual network (Vnet1), and container registry (webappcr1).  
    
     ![screenshot8 second rg](https://github.com/user-attachments/assets/f3c896b9-4c8c-4513-a5af-438dd09bde60)  
    Above: Automatically created resource group 'MC_webapp1_myAKSCluster_uksouth'.
    
      ![screenshot9 aks cluster](https://github.com/user-attachments/assets/cf6a8ad1-ba09-46c6-a58b-e889f3eb5233)  
    Above: Newly created AKS cluster (myAKSCluster) in the Azure portal.

   ![screenshot10 aks cluster node pools](https://github.com/user-attachments/assets/c30b277e-64cf-44eb-9c7e-82d113bf1979)  
    Above: Newly created AKS cluster's node pools in the Azure portal.  

9.  Configuring AKS Cluster to Pull Images from ACR  

    Used the following command to grant AKS cluster permission to pull images from ACR (webappcr1):  
    `az aks update -n myAKSCluster -g webapp1 --attach-acr webappcr1`  
    ![screenshot11 output attaching acr to aks](https://github.com/user-attachments/assets/3c0f3370-e971-4db9-a2ce-4e46da4b050b)  
    Above: Output from command, attaching ACR to AKS cluster.  

    Ran command to assign 'AcrPull' role to the AKS' managed identity:  
    `az role assignment create --assignee 3d4fef45-fd95-488b-854e-c93cf298476c --role AcrPull --scope /subscriptions/10405fd6-9675-4e3d-9721-654ceefca8ae/resourceGroups/webapp1/providers/Microsoft.ContainerRegistry/registries/webappcr1`  
    
      ![screenshot12 role assignment output](https://github.com/user-attachments/assets/0de9950b-60b4-4398-a8b2-65b3648f4585)  
    Above: Output from command re: role assignment.  

    Ran command to verify role assignment was successful:  
    `az role assignment list --assignee 3d4fef45-fd95-488b-854e-c93cf298476c --scope /subscriptions/10405fd6-9675-4e3d-9721-654ceefca8ae/resourceGroups/webapp1/providers/Microsoft.ContainerRegistry/registries/webappcr1`  

     ![screenshot13 role assignment list output](https://github.com/user-attachments/assets/4f4a2cd9-fe67-4c33-b82f-5053b77212c0)  
    Above: Output confirming role assignment. 

    Managed identity under the IAM blade of the container registry:  
    ![screenshot14 container registry new roles](https://github.com/user-attachments/assets/a849c01c-a082-4e57-a1fe-dffa762c7248)  

11. Creating the GitHub Repository  

    Created a new repository on GitHub named web-app-CI-CD-project.  

    Cloned the repository locally using:  

    `git clone https://github.com/pattytechuk/web-app-CI-CD-project.git`  


12. Initializing the Project  

    Created folders: bicep/, ci-cd/, documents/, images/ and k8s-manifests/.  

    Initialized a Git repository:  
    `git init`  

    Set remote origin:  
    `git remote add origin https://github.com/pattytechuk/web-app-CI-CD-project.git`  


13. Pushing to GitHub  

    Staged all files and committed changes:  

    `git add .`  
    `git commit -m "Initial project structure setup"`  

    Pushed to GitHub:  
    `git push -u origin main`  

## Reflection  

(Discuss challenges faced, what you learned, and areas to improve.)  

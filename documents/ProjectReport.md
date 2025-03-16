Project Report: Deploying a Containerized Web Application with Azure DevOps CI/CD Pipeline and Kubernetes

Overview

This project demonstrates my ability to set up a complete CI/CD pipeline for a web application using various tools and technologies. The purpose is to develop skills in cloud infrastructure deployment, automation/scripting, and Kubernetes management.

## Project Structure
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

Goal Setting and Requirements: My goal was to containerize a web application and automate its deployment using Azure Kubernetes Services (AKS). For the first part of the project, I manually set up the infrastructure using Bicep, set up an AKS cluster, deploy the web app into the cluster, and then verify the web application's functionality. 

For the second part of the project, I set up a pipeline in Azure DevOps' pipelines in order to automate the deployment of the infrastructure, AKS cluster, and the deployment of the web application. 

Set Up Development Environment: The following are the tools and resources I set up at the beginning:

- Installed Docker.
- Installed extensions for Visual Studio Code including Azure CLI Tools, Azure Tools, Bicep for VS Code, Docker for VS Code, and YAML.
- Set up Azure DevOps account and created a project.
- Set up Azure CLI for Azure interaction.

Application Details: I chose a sample web app using Express/Node Js available for use on on Awesome Compose's Github repo: https://github.com/docker/awesome-compose/tree/master


Steps Taken

1. Creating the GitHub Repository

Created a new repository on GitHub named web-app-CI-CD-project.

Cloned the repository locally using:

git clone https://github.com/pattytechuk/web-app-CI-CD-project.git


2. Initializing the Project

Created folders: bicep/, ci-cd/, documents/, and k8s-manifests/.

Initialized a Git repository:

git init

Set remote origin:

git remote add origin https://github.com/pattytechuk/web-app-CI-CD-project.git


3. Pushing to GitHub

Staged all files and committed changes:

git add .
git commit -m "Initial project structure setup"

Pushed to GitHub:

git push -u origin main

Next Steps

Continue documenting steps for Bicep, CI/CD configuration, and Kubernetes deployment.

Include screenshots from images/ folder as needed.

Reflection

(Discuss challenges faced, what you learned, and areas to improve.)
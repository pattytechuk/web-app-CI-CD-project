# Web App Kubernetes & CI/CD Project on Azure

## ✅ **Project Overview** 
This project deploys a containerized web app from Awesome Compose to an Azure Kubernetes Service (AKS) cluster using Bicep, Azure Container Registry, and Azure DevOps CI/CD pipelines. Some Azure CLI scripting commands were used to perform role assignment; Kubectl commands were used to monitor and modify Kubernetes cluster configs.

## ✅ **Tech Stack** 
- 🐳 Docker & Kubernetes
- ☁️ Azure AKS, ACR, Bicep, Azure CLI
- 🔁 Azure DevOps (CI/CD)

## ✅ **Setup Instructions** 
Please check out the projectreport.md for full details on steps taken on this project, including commands run, resources provisioned, and tools used.

Main commands include:  
`docker-compose up -d`  
`docker tag react-express-mongodb-frontend webappcr1.azurecr.io/mywebapp-frontend:latest`  
`docker tag react-express-mongodb-backend webappcr1.azurecr.io/mywebapp-backend:latest`  
`docker tag mongo webappcr1.azurecr.io/webapp-mongo:4.2.0`  
`az group create --name webapp1 --location UKSouth`  
`az acr create --resource-group webapp1 --name webappcr1 --sku Basic`  
`az acr repository list --name webappcr1 --output table`  
`az aks get-credentials --resource-group myResourceGroup --name myAKSCluster`
`az aks update -n myAKSCluster -g webapp1 --attach-acr webappcr1`  
`az role assignment list --assignee 3d4fef45-fd95-488b-854e-c93cf298476c --scope /subscriptions/[subscriptionid]/resourceGroups/webapp1/providers/Microsoft.ContainerRegistry/registries/webappcr1
az aks get-credentials --resource-group webapp1 --name myAKScluster`   
`kubectl apply -f deployment2.yaml`  
`kubectl get services`  
`kubectl get pods`     

High level overview of steps taken:
1. Cloned this repo from Awesome Compose, which provides collections of Docker compose examples: https://github.com/docker/awesome-compose/tree/master/react-express-mongodb 
2. Pushed Docker images to Azure Container Registry
3. Deployed AKS with Bicep & Assign Role to AKS Cluster Managed Identity using Azure CLI
4. Deployed web app with Kubernetes manifests
5. Built and automated CI/CD pipeline with Azure DevOps

## ✅ **Folder Structure** 
```
📁 web-app-CI-CD-project
│
├── 📁bicep/                # Bicep templates for infrastructure as code (IaC)
├── 📁ci-cd/                # CI/CD pipeline configurations (YAML files, scripts, etc.)
├── 📁documents/            # Documentation files 
├── 📁k8s-manifests/        # Kubernetes manifests for deploying the application
├── 📁images/               # Screenshots, images, diagrams
- README.md                  # Overview of project
- .gitignore                 # Ignore unnecessary files
```

## ✅ **Screenshots** 
Please check out more screenshots under folder 'images' in this repo. 
```
├── images/             # Screenshots, images, diagrams
```
![final_architecture_diagram](https://github.com/user-attachments/assets/2cc50787-801a-4597-950f-28141ef6ebc9)  
Above: Architecture diagram of the project.

![screenshot19](https://github.com/user-attachments/assets/e7cfe123-d4ee-4372-8dd7-fa53c3862b61)  
Above: Web application running on the front end.  

![screenshot9 aks cluster](https://github.com/user-attachments/assets/5b4eb5ae-5aaa-467e-8221-c2a62afc7096)
Above: AKS cluster running nodes/pods with the web application.  

![screenshot10 aks cluster node pools](https://github.com/user-attachments/assets/f574d202-a4f6-4726-b69a-abc1774a3efd)  
Above: AKS nodes running; systempool contains 1 VM and agentpool contains 2 VMs.  

![screenshot26 pods running](https://github.com/user-attachments/assets/dbeecfa9-435b-46c3-9670-a58524c60829)  
Above: Command confirming pods are running as expected.






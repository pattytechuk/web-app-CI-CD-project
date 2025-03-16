# Web App Kubernetes & CI/CD Project on Azure

✅ **Project Overview** 
This project deploys a containerized web app from Awesome Compose to an Azure Kubernetes Service (AKS) cluster using Bicep, Azure Container Registry, and Azure DevOps CI/CD pipelines

✅ **Tech Stack** 
- 🐳 Docker & Kubernetes
- ☁️ Azure AKS, ACR, Bicep, Azure CLI
- 🔁 Azure DevOps (CI/CD)

✅ **Setup Instructions** 
Please check out the deployment-guide.md for high-level steps to deploy
1. Clone this repo: https://github.com/docker/awesome-compose/tree/master/react-express-mongodb
2. Push Docker images to Azure Container Registry
3. Deploy AKS with Bicep & Assign Role to AKS Cluster Managed Identity using Azure CLI
4. Deploy web app with Kubernetes manifests
5. Automate CI/CD pipeline with Azure DevOps

✅ **Folder Structure** 
```
📁 web-app-CI-CD-project
│
├── 📁bicep/              # Bicep templates for infrastructure as code (IaC)
├── 📁ci-cd/              # CI/CD pipeline configurations (YAML files, scripts, etc.)
├── 📁documents/          # Documentation files 
├── 📁k8s-manifests/      # Kubernetes manifests for deploying the application
├── 📁images/             # Screenshots, images, diagrams
- README.md             # Overview of project
- .gitignore            # Ignore unnecessary files
```

✅ **Screenshots** 
Please check out more screenshots under folder 'images' in this repo. 
```
├── images/             # Screenshots, images, diagrams
```


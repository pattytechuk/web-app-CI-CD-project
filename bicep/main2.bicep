param location string = resourceGroup().location  // Same location as resource group
param clusterName string = 'myAKSCluster'
param vnetName string = 'Vnet1'
param vnetAddressPrefix string = '10.0.0.0/16' // main virtual network
param aksSubnetPrefix string = '10.0.1.0/24' // subnet for AKS cluster
param aksServiceCidr string = '10.2.0.0/16'  //  non-overlapping CIDR block for AKS service
param aksDnsServiceIp string = '10.2.0.10'  // IP address for DNS service

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [ vnetAddressPrefix ]
    }
    subnets: [
      {
        name: 'AKSSubnet'
        properties: {
          addressPrefix: aksSubnetPrefix
        }
      }
    ]
  }
}

resource aks 'Microsoft.ContainerService/managedClusters@2024-09-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'  // System-assigned managed identity for the cluster
  }
  properties: {
    dnsPrefix: clusterName
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 2
        vmSize: 'Standard_B2s'
        vnetSubnetID: vnet.properties.subnets[0].id
        osType: 'Linux'
        mode: 'User'
      },{
        name: 'systempool'
        count: 1
        vmSize: 'Standard_B2ms'
        vnetSubnetID: vnet.properties.subnets[0].id
        osType: 'Linux'
        mode: 'System'  // This is the system pool required by AKS
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      serviceCidr: aksServiceCidr // Set the new Service CIDR
      dnsServiceIP: aksDnsServiceIp
    }
  }
}



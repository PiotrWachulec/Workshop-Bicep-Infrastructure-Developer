@allowed([
  'polandcentral'
  'westeurope'
])
@description('Location of the resources')
param location string = 'polandcentral'

@description('Name of the application')
@minLength(5)
@maxLength(15)
param appName string

@description('Array of names of the blob containers')
param blobContainerNames array

var storageAccountName = '${appName}${substring(uniqueString(resourceGroup().name), 0, 3)}sa'
var defaultContainerName = 'default'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for blobContainerName in blobContainerNames: {
  parent: blobServices
  name: blobContainerName
}]

resource defaultContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = if (empty(blobContainerNames)) {
  parent: blobServices
  name: defaultContainerName
}

output storageAccountName string = storageAccount.name

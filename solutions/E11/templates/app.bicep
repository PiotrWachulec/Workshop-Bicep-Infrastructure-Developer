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

var storageAccountName = '${appName}${substring(uniqueString(resourceGroup().name), 0, 3)}sa'
var blobContainerNames = [
  'images'
  'documents'
  'videos'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for blobContainerName in blobContainerNames: {
  name: '${storageAccount.name}/default/${blobContainerName}'
}]

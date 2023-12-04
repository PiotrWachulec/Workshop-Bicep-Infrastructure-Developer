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
var blobContainerName = 'images'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }

  resource blobServices 'blobServices@2023-01-01' existing = {
    name: 'default'

    resource container 'containers@2023-01-01' = {
      name: blobContainerName
    }
  }
}

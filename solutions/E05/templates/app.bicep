@allowed([
  'polandcentral'
  'westeurope'
])
@description('Location of the resources')
param location string = 'polandcentral'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'mypwtestncsa'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

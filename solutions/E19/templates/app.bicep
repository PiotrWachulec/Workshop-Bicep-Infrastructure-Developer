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

module storageAccountModule 'storage.bicep' = {
  name: '${deployment().name}-storage'
  params: {
    appName: appName
    location: location
    blobContainerNames: blobContainerNames
  }
}

module functionAppModule 'functionApp.bicep' = {
  name: '${deployment().name}-functionApp'
  params: {
    appName: appName
    location: location
    storageAccountName: storageAccountModule.outputs.storageAccountName
  }
}

output functionAppUrl string = functionAppModule.outputs.functionAppUrl

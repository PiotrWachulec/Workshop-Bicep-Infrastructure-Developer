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

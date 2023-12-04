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

@description('Secret in the shared key vault that contains the value of the custom app setting')
@secure()
param customAppSettingSecret string

module storageAccountModule 'br:pwnctestcr.azurecr.io/storage:1.1.0' = {
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
    myCustomAppSetting: customAppSettingSecret
  }
}

output functionAppUrl string = functionAppModule.outputs.functionAppUrl

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

@description('Name of the secret in the shared key vault that contains the value of the custom app setting')
param customAppSettingSecretName string

var staticConfig = loadJsonContent('./staticConfig.json')

module storageAccountModule 'storage.bicep' = {
  name: '${deployment().name}-storage'
  params: {
    appName: appName
    location: location
    blobContainerNames: blobContainerNames
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: staticConfig.sharedKeyVault.keyVaultName
  scope: resourceGroup(staticConfig.sharedKeyVault.resourceGroupName)
}

module functionAppModule 'functionApp.bicep' = {
  name: '${deployment().name}-functionApp'
  params: {
    appName: appName
    location: location
    storageAccountName: storageAccountModule.outputs.storageAccountName
    myCustomAppSetting: keyVault.getSecret(customAppSettingSecretName)
  }
}

output functionAppUrl string = functionAppModule.outputs.functionAppUrl

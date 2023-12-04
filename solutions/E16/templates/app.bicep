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

resource hostingPlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: '${appName}-asp'
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  kind: 'windows'
}

resource functionApp 'Microsoft.Web/sites@2022-09-01' = {
  name: '${appName}-func'
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
    }
    httpsOnly: true
  }
}


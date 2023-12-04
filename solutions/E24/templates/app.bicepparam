using './app.bicep'

var staticConfig = loadJsonContent('./staticConfig.json')
var secretName = 'MY-CUSTOM-SETTING'

param location = 'polandcentral'
param appName = 'mytestpwapp'
param blobContainerNames = []
param customAppSettingSecret = az.getSecret(staticConfig.sharedKeyVault.subscriptionId, staticConfig.sharedKeyVault.resourceGroupName, staticConfig.sharedKeyVault.keyVaultName, secretName)

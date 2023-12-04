using './app.bicep'

param location = 'polandcentral'
param appName = 'mytestpwapp'
param blobContainerNames = [
  'images'
  'documents'
  'videos'
]
param customAppSettingSecretName = 'MY-CUSTOM-SETTING'

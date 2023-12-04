using './app.bicep'

param location = 'polandcentral'
param appName = 'mytestpwapp'
param blobContainerNames = [
  'images'
  'documents'
  'videos'
]

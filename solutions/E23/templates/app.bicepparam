using './app.bicep'

param location = 'polandcentral'
param appName = 'mytestpwapp'
param blobContainerNames = []
param customAppSettingSecret = az.getSecret('88a99f8e-abc3-4f87-b5d1-6582ecf72501', 'pw-test-shared-resources', 'kvpwtesttrainingprep', 'MY-CUSTOM-SETTING')

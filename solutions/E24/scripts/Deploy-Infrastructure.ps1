
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
)

$timestamp = Get-Date -Format "yyyyMMddHHmmss"

New-AzResourceGroupDeployment `
    -Name "app-$timestamp" `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile './templates/app.bicep' `
    -TemplateParameterFile './templates/app.bicepparam' `
    -Mode Complete `
    -Force

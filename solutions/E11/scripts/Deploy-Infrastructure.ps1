
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
)

New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile './templates/app.bicep' `
    -TemplateParameterFile './templates/app.bicepparam' `
    -Mode Complete `
    -Force

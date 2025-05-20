# Login via Azure CLI
az login

# Define variables
$functionAppName = "<function-app-name>"
$resourceGroupName = "<resource-group-name>"
$subscriptionId = (az account show --query id -o tsv)

# Get the function app config using REST
$apiVersion = "2022-03-01"
$url = "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Web/sites/$functionAppName/config/web?api-version=$apiVersion"

$response = az rest --method get --uri "https://management.azure.com$url" | ConvertFrom-Json

# Display CORS settings
$corsOrigins = $response.properties.cors.allowedOrigins

if (-not $corsOrigins -or $corsOrigins.Count -eq 0) {
    Write-Output "No CORS origins configured."
} else {
    Write-Output "CORS Origins for '$functionAppName':"
    $corsOrigins | ForEach-Object { Write-Output " - $_" }
}

# # Ensure Az module is installed
# if (-not (Get-Module -ListAvailable -Name Az)) {
#     Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force
# }

# # Connect to Azure interactively
# Connect-AzAccount

# Set subscription name
$targetSubscriptionName = "<Subscription-Name>"

# Get the subscription object
$subscription = Get-AzSubscription | Where-Object { $_.Name -eq $targetSubscriptionName }

if (-not $subscription) {
    Write-Host "Subscription '$targetSubscriptionName' not found. Please check the name and try again." -ForegroundColor Red
    exit
}

# Set context to the specified subscription
Set-AzContext -SubscriptionId $subscription.Id | Out-Null

# Initialize arrays
$appServicePlanData = @()
$functionAppData = @()

# Fetch App Service Plans
$appServicePlans = Get-AzAppServicePlan
foreach ($plan in $appServicePlans) {
    $appServicePlanData += [PSCustomObject]@{
        SubscriptionName = $subscription.Name
        SubscriptionId   = $subscription.Id
        ResourceGroup    = $plan.ResourceGroup
        PlanName         = $plan.Name
        Location         = $plan.Location
        Tier             = $plan.Sku.Tier
        Size             = $plan.Sku.Name
        WorkerCount      = $plan.NumberOfWorkers
        OS               = if ($plan.Reserved) { "Linux" } else { "Windows" }
    }
}

# Fetch Function Apps (filtered from web apps)
$functionApps = Get-AzWebApp | Where-Object { $_.Kind -like "*functionapp*" }
foreach ($func in $functionApps) {
    $functionAppData += [PSCustomObject]@{
        SubscriptionName = $subscription.Name
        SubscriptionId   = $subscription.Id
        ResourceGroup    = $func.ResourceGroup
        FunctionAppName  = $func.Name
        Location         = $func.Location
        State            = $func.State
        HostNames        = ($func.HostNames -join "; ")
        AppServicePlan   = $func.ServerFarmId.Split("/")[-1]
    }
}

# Export to CSV files
$appServicePlanData | Export-Csv -Path "./AppServicePlans.csv" -NoTypeInformation -Encoding UTF8
$functionAppData    | Export-Csv -Path "./FunctionApps.csv" -NoTypeInformation -Encoding UTF8

Write-Host "`nExport complete. Files saved as 'AppServicePlans.csv' and 'FunctionApps.csv'."

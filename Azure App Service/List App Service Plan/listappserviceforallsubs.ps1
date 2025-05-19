# # Ensure Az module is installed
# if (-not (Get-Module -ListAvailable -Name Az)) {
#     Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force
# }

# # Connect to Azure2
# Connect-AzAccount

# Prepare arrays to hold data
$appServicePlanData = @()
$functionAppData = @()

# Get all subscriptions
$subscriptions = Get-AzSubscription

foreach ($sub in $subscriptions) {
    Write-Host "`nProcessing subscription: $($sub.Name) [$($sub.Id)]"
    
    # Set current subscription context
    Set-AzContext -SubscriptionId $sub.Id | Out-Null

    # Get App Service Plans
    $plans = Get-AzAppServicePlan
    foreach ($plan in $plans) {
        $appServicePlanData += [PSCustomObject]@{
            SubscriptionName = $sub.Name
            SubscriptionId   = $sub.Id
            ResourceGroup    = $plan.ResourceGroup
            PlanName         = $plan.Name
            Location         = $plan.Location
            Tier             = $plan.Sku.Tier
            Size             = $plan.Sku.Name
            WorkerCount      = $plan.NumberOfWorkers
            OS               = if ($plan.Reserved) { "Linux" } else { "Windows" }
        }
    }

    # Get Function Apps
    $webApps = Get-AzWebApp | Where-Object { $_.Kind -like "*functionapp*" }
    foreach ($func in $webApps) {
        $functionAppData += [PSCustomObject]@{
            SubscriptionName = $sub.Name
            SubscriptionId   = $sub.Id
            ResourceGroup    = $func.ResourceGroup
            FunctionAppName  = $func.Name
            Location         = $func.Location
            State            = $func.State
            HostNames        = ($func.HostNames -join "; ")
            AppServicePlan   = $func.ServerFarmId.Split("/")[-1]
        }
    }
}

# Export to CSV files
$appServicePlanData | Export-Csv -Path "./AppServicePlans.csv" -NoTypeInformation -Encoding UTF8
$functionAppData | Export-Csv -Path "./FunctionApps.csv" -NoTypeInformation -Encoding UTF8

Write-Host "`nExport complete. Files saved as 'AppServicePlans.csv' and 'FunctionApps.csv' in current directory."

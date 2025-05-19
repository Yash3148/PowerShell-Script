# Azure App Service and Function App Exporter

## Overview

This PowerShell script, **`listappservice.ps1`**, connects to a specified Azure subscription and retrieves details about App Service Plans and Function Apps. It then exports this information into two separate CSV files for easy access and analysis.

## What the PowerShell Script Does

1. **Module Check**: It checks if the Azure PowerShell module (`Az`) is installed. If not, it installs the module automatically.
2. **Azure Authentication**: The script prompts the user to log in to their Azure account interactively.
3. **Subscription Selection**: The user specifies the Azure subscription by name. The script verifies the existence of this subscription.
4. **Data Retrieval**:
   - **App Service Plans**: It fetches details of all App Service Plans associated with the specified subscription.
   - **Function Apps**: It retrieves details of all Function Apps filtered from web applications within the subscription.
5. **Data Export**: The retrieved data is exported into two CSV files:
   - `AppServicePlans.csv`
   - `FunctionApps.csv`

## Expected Output

After running the script, two CSV files will be generated in the current directory:

1. **AppServicePlans.csv**: Contains the following columns:
   - `SubscriptionName`: The name of the Azure subscription.
   - `SubscriptionId`: The ID of the Azure subscription.
   - `ResourceGroup`: The resource group associated with the App Service Plan.
   - `PlanName`: The name of the App Service Plan.
   - `Location`: The Azure region where the plan is hosted.
   - `Tier`: The pricing tier of the App Service Plan.
   - `Size`: The size of the App Service Plan.
   - `WorkerCount`: The number of workers allocated to the plan.
   - `OS`: The operating system (Windows or Linux) used by the plan.

2. **FunctionApps.csv**: Contains the following columns:
   - `SubscriptionName`: The name of the Azure subscription.
   - `SubscriptionId`: The ID of the Azure subscription.
   - `ResourceGroup`: The resource group associated with the Function App.
   - `FunctionAppName`: The name of the Function App.
   - `Location`: The Azure region where the Function App is hosted.
   - `State`: The current state of the Function App (e.g., Running, Stopped).
   - `HostNames`: The host names associated with the Function App.
   - `AppServicePlan`: The name of the App Service Plan to which the Function App is linked.

## Author

Yash Singh

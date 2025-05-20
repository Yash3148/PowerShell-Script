# Azure Function App CORS Configuration Viewer

## Overview

This PowerShell script retrieves and displays the CORS (Cross-Origin Resource Sharing) settings for a specified Azure Function App using the Azure CLI and REST API.

## What the Script Does

1. **Azure CLI Login**: The script starts by logging into Azure using the Azure CLI command `az login`. Ensure you have the Azure CLI installed and configured on your machine.
   
2. **Define Variables**: 
   - It sets the variables for the Function App name and the Resource Group name. You need to replace `<function-app-name>` and `<resource-group-name>` with your actual Function App and Resource Group names.
   - It retrieves the current subscription ID using the Azure CLI.

3. **REST API Call**: 
   - The script constructs a URL to access the Function App's configuration settings via the Azure Management REST API.
   - It specifies the API version as `2022-03-01`.

4. **Get CORS Settings**: 
   - The script sends a GET request to the constructed URL using the `az rest` command and converts the JSON response into a PowerShell object.

5. **Display CORS Settings**: 
   - It checks if any CORS origins are configured for the Function App. 
   - If no origins are configured, it outputs "No CORS origins configured."
   - If there are configured origins, it lists them.

## Expected Output

When you run the script, you can expect one of the following outputs:

- If no CORS origins are configured:
  ```
  No CORS origins configured.
  ```

- If CORS origins are configured, it will display:
  ```
  CORS Origins for '<function-app-name>':
   - <origin1>
   - <origin2>
   ...
  ```

## Usage Instructions

To use the script:

1. Open PowerShell.
2. Ensure you have the Azure CLI installed and configured.
3. Replace `<function-app-name>` and `<resource-group-name>` with your actual Function App and Resource Group names in the script.
4. Execute the script by running:

   
## Author

Yash Singh

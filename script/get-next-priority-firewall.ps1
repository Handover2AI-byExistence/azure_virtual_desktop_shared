#-------------------------------------------------------------------------------------------------------------------------------------
# This powershell script fetches the latest priority of the firewalll rules
#-------------------------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------------------------
# Config off environment variables for CI/CD
#-------------------------------------------------------------------------------------------------------------------------------------

param(
    [Parameter(Mandatory = $true)][string]$SubscriptionId,
    [Parameter(Mandatory = $true)][string]$ResourceGroup,
    [Parameter(Mandatory = $true)][string]$PolicyName,
    [Parameter(Mandatory = $false)][string]$OutputFile = "./priority.env"
)

#-------------------------------------------------------------------------------------------------------------------------------------
# Fetch Azure token using Azure CLI (works in pipeline with az login)
#-------------------------------------------------------------------------------------------------------------------------------------
$token = az account get-access-token --resource https://management.azure.com --query accessToken -o tsv
if (-not $token) {
    Write-Error "Unable to retrieve Azure access token. Make sure 'az login' has been executed."
    exit 1
}

#-------------------------------------------------------------------------------------------------------------------------------------
# Fetch all Rule Collection Groups via REST API
#-------------------------------------------------------------------------------------------------------------------------------------
$uri = "https://management.azure.com/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroup/providers/Microsoft.Network/firewallPolicies/$PolicyName/ruleCollectionGroups?api-version=2023-02-01"

try {
    $response = Invoke-RestMethod -Uri $uri -Method Get -Headers @{ Authorization = "Bearer $token" }
}
catch {
    Write-Error "Failed to fetch Rule Collection Groups: $_"
    exit 1
}

#-------------------------------------------------------------------------------------------------------------------------------------
# Determine the highest existing priority
#-------------------------------------------------------------------------------------------------------------------------------------
if (-not $response.value -or $response.value.Count -eq 0) {
    Write-Output "No Rule Collection Groups found at policy '$PolicyName'."
    $maxPriority = 0
}
else {
    $priorities = $response.value | ForEach-Object { $_.properties.priority }
    $maxPriority = ($priorities | Measure-Object -Maximum).Maximum
}

Write-Output "Last used priority: $maxPriority"

# Next available priority (step 10)
$nextPriority = $maxPriority + 10
Write-Output "Next available priority: $nextPriority"

#-------------------------------------------------------------------------------------------------------------------------------------
# Export to Terraform variable (also write to file for pipeline)
#-------------------------------------------------------------------------------------------------------------------------------------
$env:TF_VAR_priority = $nextPriority

# Write to file for Terraform
"TF_VAR_priority=$nextPriority" | Out-File -FilePath $OutputFile -Encoding utf8 -Force

Write-Output "TF_VAR_priority exported to $OutputFile"

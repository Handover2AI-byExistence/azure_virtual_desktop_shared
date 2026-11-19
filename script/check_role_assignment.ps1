param (
    [string]$Scope,
    [string]$Role,
    [string]$PrincipalId
)

# Ensure errors stop execution
$ErrorActionPreference = "Stop"

# Get assignments via Azure CLI
$assignments = az role assignment list `
    --scope $Scope `
    --role $Role `
    --assignee $PrincipalId `
    --query "[].id" `
    --output tsv

if ([string]::IsNullOrWhiteSpace($assignments)) {
    # No assignments
    $result = @{
        exists = "false"
    }
} else {
    # At least one assignment
    $result = @{
        exists = "true"
    }
}

# Output JSON for Terraform
$result | ConvertTo-Json -Compress

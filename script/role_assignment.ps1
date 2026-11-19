param(
    [string]$Scope,
    [string]$Role,
    [string]$PrincipalId
)

Write-Host "Checking role assignment for $PrincipalId on $Scope..."

$assignment = az role assignment list --scope $Scope --role "$Role" --assignee $PrincipalId | ConvertFrom-Json

if ($assignment.Count -gt 0) {
    Write-Host "Assignment already exists"
}
else {
    Write-Host "Creating new role assignment..."
    az role assignment create --assignee $PrincipalId --role "$Role" --scope $Scope | Out-Null
    Write-Host "Role assignment created."
}

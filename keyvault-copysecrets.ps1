$secretsToCopy = @(
    "xxx",
    "yyy",
    "zzz"
)

# Source and destination Key Vault names
$sourceVaultName = "xxx-kv"
$destinationVaultName = "yyy-kv"

# User details
$userName = "xxx@xxx.com"
$userObjectId = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# -------------------------------------------------------

# Set the appropriate permissions for the access policy
$permissions = @("list", "get", "set")

# Add the access policy to the destination vault
az keyvault set-policy --name $destinationVaultName --object-id $userObjectId --secret-permissions $permissions

# Iterate over the secrets and copy them
foreach ($secretName in $secretsToCopy) {
    $sourceSecret = az keyvault secret show --vault-name $sourceVaultName --name $secretName --query "value" -o tsv
    $result = az keyvault secret set --vault-name $destinationVaultName --name $secretName --value $sourceSecret
}

Write-Host "Secrets copied successfully!"

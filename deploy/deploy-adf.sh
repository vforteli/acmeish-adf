rg='acme-adftest-rg'

echo "Creating deployment stack"
result=$(az stack group create \
  --name 'adftest-prod-adf' \
  --resource-group $rg \
  --template-file 'acmeish-dev-adf/ARMTemplateForFactory.json' \
  --parameters './parameters/parameters-prod.json' \
  --deny-settings-mode 'none' \
  --action-on-unmanage 'deleteResources' \
  --yes)


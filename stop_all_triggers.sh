ADF_NAME=acmeish-prod-adf
RG_NAME=acme-adftest-rg

echo "Checking for triggers to stop..."
names=`az datafactory trigger list --factory-name $ADF_NAME --resource-group $RG_NAME --query "[?properties.runtimeState == 'Started'].name" -o tsv --only-show-errors`
                    
for name in ${names[@]}; 
do
    echo "Stopping the trigger : ${name}"
    az datafactory trigger stop --factory-name $ADF_NAME --resource-group $RG_NAME --name ${name} --only-show-errors
done
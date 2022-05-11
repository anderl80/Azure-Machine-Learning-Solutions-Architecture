export SERVICENAME=ComputerVision
export REGION=westeurope
export RESOURCEGROUP=rg-aml-book-cogsrv
export SKU=F0

az group create --name $RESOURCEGROUP --location $REGION
az cognitiveservices account create --name $SERVICENAME --resource-group $RESOURCEGROUP --kind $SERVICENAME --sku $SKU --location $REGION --yes

export SUBSCRIPTION_ID=$(az account show --query id -o tsv)
export ACCOUNT_REGION=$(az cognitiveservices account show --resource-group $RESOURCEGROUP --name $SERVICENAME --query location --output tsv)
export ACCOUNT_KEY=$(az cognitiveservices account keys list --resource-group $RESOURCEGROUP --name $SERVICENAME --query key1 --output tsv)

echo "SERVICENAME=$SERVICENAME" > .env
echo "RESOURCEGROUP=$RESOURCEGROUP" >> .env
echo "ACCOUNT_REGION=$ACCOUNT_REGION" >> .env
echo "ACCOUNT_KEY=$ACCOUNT_KEY" >> .env
echo "SUBSCRIPTION_ID=$SUBSCRIPTION_ID" >> .env
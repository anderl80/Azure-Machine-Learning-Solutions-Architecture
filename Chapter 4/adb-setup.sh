export SERVICENAME=adb-quickstart
export REGION=westeurope
export RESOURCEGROUP=rg-aml-book-adb
export SKU=premium

az extension add --name databricks
az group create --name $RESOURCEGROUP --location $REGION
az databricks workspace create --resource-group $RESOURCEGROUP --name $SERVICENAME --location $REGION --sku $SKU
export WORKSPACE_URL=$(az databricks workspace list | jq '.[] | select(.resourceGroup | test("rg-aml-book-adb")) | .workspaceUrl' | tr -d '"')

echo "SERVICENAME=$SERVICENAME" > .env
echo "RESOURCEGROUP=$RESOURCEGROUP" >> .env
echo "WORKSPACE_URL=$WORKSPACE_URL" >> .env

# Databricks CLI
pip install --upgrade databricks-cli

# Two ways to authenticate
# (1) PAT https://docs.microsoft.com/en-us/azure/databricks/dev-tools/cli/#set-up-authentication-using-a-databricks-personal-access-token
# need to set https://docs.microsoft.com/en-us/azure/databricks/dev-tools/api/latest/authentication#store-tokens-in-a-netrc-file-and-use-them-in-curl
curl --netrc --request POST \
https://$WORKSPACE_URL/api/2.0/token/create \
--data '{ "comment": "Databricks CLI access token", "lifetime_seconds": 7776000 }' \
| jq .

# (2) https://docs.microsoft.com/en-us/azure/databricks/dev-tools/cli/#--set-up-authentication-using-an-azure-ad-token

databricks clusters create --json-file adb-cluster-standard.json

databricks fs cp ML\ Quickstart_\ Model\ Training.py dbfs:/.

# https://menziess.github.io/howto/run/databricks-notebooks-from-devops/


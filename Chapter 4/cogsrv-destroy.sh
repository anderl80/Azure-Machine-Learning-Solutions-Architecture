. .env

az group delete --name $RESOURCEGROUP -y
# Soft delete takes 48h to completely delete the resource. To purge, adapt thew following.
az resource delete --ids /subscriptions/$SUBSCRIPTION_ID/providers/Microsoft.CognitiveServices/locations/$ACCOUNT_REGION/resourceGroups/$RESOURCEGROUP/deletedAccounts/$SERVICENAME --verbose

rm .env
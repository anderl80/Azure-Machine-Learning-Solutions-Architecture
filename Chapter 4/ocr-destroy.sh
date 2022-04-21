RESOURCEGROUP=rg-aml-book-cogsrv

az group delete --name $RESOURCEGROUP -y
# Soft delete takes 48h to completely delete the resource. To purge, adapt thew following.
# az resource delete --ids /subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/locations/{location}/resourceGroups/{resourceGroup}/deletedAccounts/{resourceName}
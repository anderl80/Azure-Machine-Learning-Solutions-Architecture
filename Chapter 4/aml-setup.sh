export SERVICENAME=aml-quickstart
export REGION=westeurope
export RESOURCEGROUP=rg-aml-book-aml
export ENDPOINT_NAME="diabetes-endpoint"

az extension add -n ml -y
az group create --name $RESOURCEGROUP --location $REGION
az configure --defaults workspace=$SERVICENAME group=$RESOURCEGROUP location=$REGION
az ml workspace create --resource-group $RESOURCEGROUP --name $SERVICENAME
az ml compute create -n cpu-cluster --type amlcompute --min-instances 0 --max-instances 8 --resource-group $RESOURCEGROUP --workspace-name $SERVICENAME
run_id=$(az ml job create -f job.yml --stream --resource-group $RESOURCEGROUP --workspace-name $SERVICENAME --query name -o tsv)
# https://docs.microsoft.com/en-us/azure/machine-learning/how-to-deploy-mlflow-models-online-endpoints?tabs=endpoint%2Cstudio
# https://github.com/Azure/azureml-examples/tree/main/cli/endpoints/online/mlflow
az ml job download -n $run_id
az ml online-endpoint create --name $ENDPOINT_NAME -f create-endpoint.yml
az ml online-deployment create --name sklearn-deployment --endpoint $ENDPOINT_NAME -f sklearn-deployment.yml --all-traffic
az ml online-endpoint invoke --name $ENDPOINT_NAME --request-file sample-request.json

echo "SERVICENAME=$SERVICENAME" > .env
echo "RESOURCEGROUP=$RESOURCEGROUP" >> .env
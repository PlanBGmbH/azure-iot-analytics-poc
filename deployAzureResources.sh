#!/bin/bash
resource_group_name="iot-analytics-poc"
location="westeurope"

# group_exits=$(az group exists --name $resource_group_name --output tsv);
# group_exits=$(echo "$group_exits" | tr -d '\r')

# echo "Create Azure resources"
# if [ $group_exits = false ]; then
#     echo "Group does not exists"
# else
#     echo "Group exists and will be deleted first"
#     # az group delete --name $resource_group_name --yes
# fi

# az group create --name $resource_group_name --location $location
# az deployment group create -f ./main.bicep -g $resource_group_name

output=$(az deployment group create -f ./main.bicep -g $resource_group_name --query "properties.outputs");



# a=$output | jq '.iothubId.value'

echo "$output"

iot_hub_id_output=$(echo "$output" | jq '.iothubId.value')
echo "$iot_hub_id_output"

storage_account_id_output=$(echo "$output" | jq '.storageId.value')
echo "$storage_account_id_output"

event_hub_id_output=$(echo "$output" | jq '.eventHubId.value')
echo "$event_hub_id_output"


# storage_account_id=$(az deployment group create -f ./main.bicep -g $resource_group_name --query "properties.outputs.storageId.value");

# storage_account_id_output="/subscriptions/e687f850-b05f-4061-8ccc-e950cca41423/resourceGroups/iot-analytics-poc/providers/Microsoft.Storage/storageAccounts/strrl54wdd5taawo"
# echo "$storage_account_id"

regex_pattern="IotHubs\/([a-zA-Z0-9\-]*)"
if [[ $iot_hub_id_output =~ $regex_pattern ]]
then
    iot_hub_account_id=${BASH_REMATCH[1]}
    echo "$iot_hub_account_id"
else
    echo "no match found"
fi

regex_pattern="storageAccounts\/([a-zA-Z0-9]*)"
if [[ $storage_account_id_output =~ $regex_pattern ]]
then
    storage_account_id=${BASH_REMATCH[1]}
    echo "$storage_account_id"
else
    echo "no match found"
fi

regex_pattern="\/eventhubs\/([a-zA-Z0-9\-]*)"
if [[ $event_hub_id_output =~ $regex_pattern ]]
then
    event_hub_id=${BASH_REMATCH[1]}
    echo "$event_hub_id"
else
    echo "no match found"
fi

event_hub_namespace_id_output=$(echo "$output" | jq '.eventHubNamespaceId.value')
echo "$event_hub_namespace_id_output"
regex_pattern="\/Microsoft.EventHub\/namespaces\/([a-zA-Z0-9\-]*)"
if [[ $event_hub_namespace_id_output =~ $regex_pattern ]]
then
    event_hub_namespace_id=${BASH_REMATCH[1]}
    echo "$event_hub_namespace_id"
else
    echo "no match found"
fi

regex_pattern="\/subscriptions\/([a-f0-9\-]*)\/"
if [[ $storage_account_id_output =~ $regex_pattern ]]
then
    subscription_id=${BASH_REMATCH[1]}
    echo "$subscription_id"
else
    echo "no match found"
fi


# az storage account keys list --resource-group $resource_group_name -n $storage_account_id

# az storage account show-connection-string  --resource-group $resource_group_name -n $storage_account_id



# # az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name MyIotHub --endpoint-name E2 --endpoint-type eventhub --endpoint-resource-group {ResourceGroup} --endpoint-subscription-id {SubscriptionId} --connection-string {ConnectionString}




# # echo 'employee_id=1234' | grep -Eo '[0-9]+'
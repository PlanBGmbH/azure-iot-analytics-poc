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
az deployment group create -f ./main.bicep -g $resource_group_name

output=$(az deployment group create -f ./main.bicep -g $resource_group_name --query "properties.outputs");
echo "$output"
echo

iot_hub_id_output=$(echo "$output" | jq '.iothubId.value')
echo "$iot_hub_id_output"
regex_pattern="IotHubs\/([a-zA-Z0-9\-]*)"
if [[ $iot_hub_id_output =~ $regex_pattern ]]
then
    iot_hub_id=${BASH_REMATCH[1]}
    echo "$iot_hub_id"
else
    echo "no match found"
fi
echo

storage_account_id_output=$(echo "$output" | jq '.storageId.value')
echo "$storage_account_id_output"
regex_pattern="storageAccounts\/([a-zA-Z0-9]*)"
if [[ $storage_account_id_output =~ $regex_pattern ]]
then
    storage_account_id=${BASH_REMATCH[1]}
    echo "$storage_account_id"
else
    echo "no match found"
fi
echo

event_hub_id_output=$(echo "$output" | jq '.eventHubId.value')
echo "$event_hub_id_output"
regex_pattern="\/eventhubs\/([a-zA-Z0-9\-]*)"
if [[ $event_hub_id_output =~ $regex_pattern ]]
then
    event_hub_id=${BASH_REMATCH[1]}
    echo "$event_hub_id"
else
    echo "no match found"
fi
echo

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
echo

regex_pattern="\/subscriptions\/([a-f0-9\-]*)\/"
if [[ $storage_account_id_output =~ $regex_pattern ]]
then
    subscription_id=${BASH_REMATCH[1]}
    echo "$subscription_id"
else
    echo "no match found"
fi
echo

sh ./configureConnections.sh $resource_group_name $storage_account_id $iot_hub_id $subscription_id
# az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name $iot_hub_id --endpoint-name E2 --endpoint-type eventhub --endpoint-resource-group $resource_group_name --endpoint-subscription-id $subscription_id --connection-string {ConnectionString}

# az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name $iot_hub_id --endpoint-name E2 --endpoint-type eventhub --endpoint-resource-group $resource_group_name --endpoint-subscription-id $subscription_id --connection-string {ConnectionString}
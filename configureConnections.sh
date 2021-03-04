#!/bin/bash
resource_group_name=$1
storage_account_id=$2
iot_hub_id=$3
subscription_id=$4
echo $resource_group_name
echo $storage_account_id
echo $iot_hub_id
echo $subscription_id

# az storage account show-connection-string  --resource-group $resource_group_name -n $storage_account_id

connection_string_output=$(az storage account show-connection-string  --resource-group $resource_group_name -n $storage_account_id);
# echo "$connection_string_output"
# echo

connection_string=$(echo "$connection_string_output" | jq '.connectionString')
connection_string=$(echo "$connection_string" | tr -d '`"')
echo "$connection_string"
echo


az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name $iot_hub_id --endpoint-name blobRawMeasureData --endpoint-type azurestoragecontainer --endpoint-resource-group $resource_group_name --endpoint-subscription-id $subscription_id --connection-string $connection_string --container-name iothubrawdata --batch-frequency 60 --chunk-size 100 --ff {iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm} --encoding json
az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name $iot_hub_id --endpoint-name twinchanges2blob --endpoint-type azurestoragecontainer --endpoint-resource-group $resource_group_name --endpoint-subscription-id $subscription_id --connection-string $connection_string --container-name iothubtwinchanges --batch-frequency 60 --chunk-size 100 --ff {iothub}/{YYYY}/{MM}/{DD}/{HH}/{mm}/{partition} --encoding json
#!/bin/bash
resource_group_name=$1
storage_account_id=$2
iot_hub_id=$3
subscription_id=$4
event_hub_namespace_id=$5
event_hub_id=$6
event_hub_id_adedirectdigitallab=$7
event_hub_id_aintestingdirect1016247=$8
echo $resource_group_name
echo $storage_account_id
echo $iot_hub_id
echo $subscription_id
echo $event_hub_namespace_id
echo $event_hub_id
echo $event_hub_id_adedirectdigitallab
echo $event_hub_id_aintestingdirect1016247

# az storage account show-connection-string  --resource-group $resource_group_name -n $storage_account_id

connection_string_output=$(az storage account show-connection-string  --resource-group $resource_group_name -n $storage_account_id);
# echo "$connection_string_output"
# echo

connection_string=$(echo "$connection_string_output" | jq '.connectionString')
connection_string=$(echo "$connection_string" | tr -d '`"')
echo "$connection_string"
echo


# az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name $iot_hub_id --endpoint-name blobRawMeasureData --endpoint-type azurestoragecontainer --endpoint-resource-group $resource_group_name --endpoint-subscription-id $subscription_id --connection-string $connection_string --container-name iothubrawdata --batch-frequency 60 --chunk-size 100 --ff {iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm} --encoding json
# az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name $iot_hub_id --endpoint-name twinchanges2blob --endpoint-type azurestoragecontainer --endpoint-resource-group $resource_group_name --endpoint-subscription-id $subscription_id --connection-string $connection_string --container-name iothubtwinchanges --batch-frequency 60 --chunk-size 100 --ff {iothub}/{YYYY}/{MM}/{DD}/{HH}/{mm}/{partition} --encoding json

# az eventhubs eventhub authorization-rule list --resource-group $resource_group_name --namespace-name $event_hub_namespace_id --eventhub-name $event_hub_id
eventhub_authorization_rule_name=$(az eventhubs eventhub authorization-rule list --resource-group $resource_group_name --namespace-name $event_hub_namespace_id --eventhub-name $event_hub_id --query "[].name" --output tsv)
eventhub_authorization_rule_name=$(echo "$eventhub_authorization_rule_name" | tr -d '\r')
echo "eventhub_authorization_rule_name:" $eventhub_authorization_rule_name
echo

eventhub_authorization_rule_name_adedirectdigitallab=$(az eventhubs eventhub authorization-rule list --resource-group $resource_group_name --namespace-name $event_hub_namespace_id --eventhub-name $event_hub_id_adedirectdigitallab --query "[].name" --output tsv)
eventhub_authorization_rule_name_adedirectdigitallab=$(echo "$eventhub_authorization_rule_name_adedirectdigitallab" | tr -d '\r')
echo "eventhub_authorization_rule_name_adedirectdigitallab:" $eventhub_authorization_rule_name_adedirectdigitallab
echo

eventhub_authorization_rule_name_aintestingdirect1016247=$(az eventhubs eventhub authorization-rule list --resource-group $resource_group_name --namespace-name $event_hub_namespace_id --eventhub-name $event_hub_id_aintestingdirect1016247 --query "[].name" --output tsv)
eventhub_authorization_rule_name_aintestingdirect1016247=$(echo "$eventhub_authorization_rule_name_aintestingdirect1016247" | tr -d '\r')
echo "eventhub_authorization_rule_name_aintestingdirect1016247:" $eventhub_authorization_rule_name_aintestingdirect1016247
echo

# az eventhubs eventhub authorization-rule list --resource-group $resource_group_name --namespace-name $event_hub_namespace_id --eventhub-name $event_hub_id --query "[].name" --output tsv


# az eventhubs eventhub authorization-rule list --resource-group myresourcegroup --namespace-name mynamespace --eventhub-name myeventhub
# az eventhubs eventhub authorization-rule keys list --resource-group $resource_group_name --namespace-name $event_hub_namespace_id --eventhub-name event_hub_id --name $SASname1 --query "primaryConnectionString")
# az eventhubs eventhub authorization-rule keys list --resource-group myresourcegroup --namespace-name mynamespace --eventhub-name myeventhub --name myauthorule


# # az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name $iot_hub_id --endpoint-name E2 --endpoint-type eventhub --endpoint-resource-group $resource_group_name --endpoint-subscription-id $subscription_id --connection-string {ConnectionString}
# # az iot hub routing-endpoint create --resource-group $resource_group_name --hub-name $iot_hub_id --endpoint-name asaEnrichMeasureData --endpoint-type eventhub --endpoint-resource-group $resource_group_name --endpoint-subscription-id $subscription_id --connection-string {ConnectionString}

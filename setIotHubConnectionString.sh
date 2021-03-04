#!/bin/bash
echo "Getting IoT Values values"

echo
iot_hub_name=$(az iot hub list --query "[].name" --output tsv)
iot_hub_name=$(echo "$iot_hub_name" | tr -d '\r')
echo "iot_hub_name:" $iot_hub_name

iot_hub_connection_string=$(az iot hub device-identity connection-string show --hub-name $iot_hub_name --device-id MyDotnetDevice --query "connectionString")
iot_hub_connection_string=$(echo "$iot_hub_connection_string" | tr -d '\r')
echo "iot_hub_connection_string:" $iot_hub_connection_string

echo "Create appsettings.json"
echo
app_settings="{\"IoTHubConnectionString\": $iot_hub_connection_string}"

jq -n "$app_settings" > ./IoTDevice/appsettings.json
cat ./IoTDevice/appsettings.json



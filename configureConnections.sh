#!/bin/bash
resource_group_name="iot-analytics-poc"
location="westeurope"


# cat temp.json | jq '.iothubId.value'
temp=$(cat temp.json)
iotHubId=$(echo "$temp" | jq '.iothubId.value')
echo "$iotHubId"
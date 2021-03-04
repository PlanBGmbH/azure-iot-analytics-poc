#!/bin/bash
resource_group_name="iot-analytics-poc"
location="westeurope"

group_exits=$(az group exists --name $resource_group_name --output tsv);
group_exits=$(echo "$group_exits" | tr -d '\r')

echo "Create Azure resources"
if [ $group_exits = false ]; then
    echo "Group does not exists"
else
    echo "Group exists and will be deleted first"
    # az group delete --name $resource_group_name --yes
fi

az group create --name $resource_group_name --location $location
az deployment group create -f ./main.bicep -g $resource_group_name
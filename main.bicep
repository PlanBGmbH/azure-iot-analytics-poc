param storage_account_name string = 'str${uniqueString(resourceGroup().id)}'
param iot_hub_name string = 'iot-${uniqueString(resourceGroup().id)}'
param iot_hub_provisioning_service_name string = 'iot-ps-${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location

param appinsights_name string = 'appi-${uniqueString(resourceGroup().id)}'
resource appinsights 'Microsoft.Insights/components@2018-05-01-preview' = {
  location: location
  name: appinsights_name
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource storage_account 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource iothub 'Microsoft.Devices/IotHubs@2020-04-01' = {
  name: iot_hub_name
  location: location
  sku: {
      name: 'S1'
      capacity: 1
  }
}

resource iotps 'Microsoft.Devices/provisioningServices@2020-01-01' = {
    name: iot_hub_provisioning_service_name
    location: location
    sku: {
        name: 'S1'
        capacity: 1
    }

    properties: {
        iotHubs: [
            {
                connectionString: 'HostName=${iothub.name}.azure-devices.net;SharedAccessKeyName=${listKeys(iothub.id, '2020-04-01').value[0].keyName};SharedAccessKey=${listKeys(iothub.id, '2020-04-01').value[0].primaryKey}'
                location: location
            }
        ]
    }
}
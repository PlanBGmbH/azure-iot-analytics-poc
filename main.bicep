param location string = resourceGroup().location
param diagnostic_settings_name string = 'diagsettings'

param log_analytics_name string = 'log-${uniqueString(resourceGroup().id)}'
resource log_analytics 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: log_analytics_name
  location: location
  properties: {
    sku: {
      name: 'Free'
    }
  }
}
param appinsights_name string = 'appi-${uniqueString(resourceGroup().id)}'
resource appinsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  location: location
  name: appinsights_name
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: log_analytics.id
  }
}
resource appinsights_diagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
  name: diagnostic_settings_name
  scope: appinsights
  properties: {
    workspaceId: log_analytics.id
    logAnalyticsDestinationType: 'Dedicated'
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        category: 'AppAvailabilityResults'
        enabled: true
      }
      {
        category: 'AppBrowserTimings'
        enabled: true
      }
      {
        category: 'AppEvents'
        enabled: true
      }
      {
        category: 'AppMetrics'
        enabled: true
      }
      {
        category: 'AppDependencies'
        enabled: true
      }
      {
        category: 'AppExceptions'
        enabled: true
      }
      {
        category: 'AppPageViews'
        enabled: true
      }
      {
        category: 'AppPerformanceCounters'
        enabled: true
      }
      {
        category: 'AppRequests'
        enabled: true
      }
      {
        category: 'AppSystemEvents'
        enabled: true
      }
      {
        category: 'AppTraces'
        enabled: true
      }
    ]
  }
}

param event_hub_namespace_name string = 'evhns-${uniqueString(resourceGroup().id)}'
resource event_hub_namespace 'Microsoft.EventHub/namespaces@2018-01-01-preview' = {
  name: event_hub_namespace_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
output eventHubNamespaceId string = event_hub_namespace.id

resource event_hub_diagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
  name: diagnostic_settings_name
  scope: event_hub_namespace
  properties: {
    workspaceId: log_analytics.id
    logAnalyticsDestinationType: 'Dedicated'
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        category: 'ArchiveLogs'
        enabled: true
      }
      {
        category: 'OperationalLogs'
        enabled: true
      }
      {
        category: 'AutoScaleLogs'
        enabled: true
      }
      {
        category: 'KafkaCoordinatorLogs'
        enabled: true
      }
      {
        category: 'KafkaUserErrorLogs'
        enabled: true
      }
      {
        category: 'EventHubVNetConnectionEvent'
        enabled: true
      }
      {
        category: 'CustomerManagedKeyUserLogs'
        enabled: true
      }
    ]
  }
}

param event_hub_name string = 'evh-${uniqueString(resourceGroup().id)}'
resource event_hub 'Microsoft.EventHub/namespaces/eventhubs@2017-04-01' = {
  name: concat(event_hub_namespace.name, '/', event_hub_name)
  properties: {
    partitionCount: 1
    messageRetentionInDays: 1
  }
}
output eventHubId string = event_hub.id

param event_hub_adedirectdigitallab_name string = 'adedirectdigitallab'
resource event_hub_adedirectdigitallab 'Microsoft.EventHub/namespaces/eventhubs@2017-04-01' = {
  name: concat(event_hub_namespace.name, '/', event_hub_adedirectdigitallab_name)
  properties: {
    partitionCount: 1
    messageRetentionInDays: 1
  }
}
output eventHubIdAdedirectdigitallab string = event_hub_adedirectdigitallab.id


param event_hub_aintestingdirect1016247_name string = 'aintestingdirect1016247'
resource event_hub_aintestingdirect1016247 'Microsoft.EventHub/namespaces/eventhubs@2017-04-01' = {
  name: concat(event_hub_namespace.name, '/', event_hub_aintestingdirect1016247_name)
  properties: {
    partitionCount: 1
    messageRetentionInDays: 1
  }
}
output eventHubIdAintestingdirect1016247 string = event_hub_aintestingdirect1016247.id

param event_hub_asaenrich2routingapp_name string = 'asaenrich2routingapp'
resource event_hub_asaenrich2routingapp 'Microsoft.EventHub/namespaces/eventhubs@2017-04-01' = {
  name: concat(event_hub_namespace.name, '/', event_hub_asaenrich2routingapp_name)
  properties: {
    partitionCount: 1
    messageRetentionInDays: 1
  }
}
output eventHubIdAsaenrich2routingapp string = event_hub_asaenrich2routingapp.id


param event_hub_iothub2asadigitallab_name string = 'iothub2asadigitallab'
resource event_hub_iothub2asadigitallab 'Microsoft.EventHub/namespaces/eventhubs@2017-04-01' = {
  name: concat(event_hub_namespace.name, '/', event_hub_iothub2asadigitallab_name)
  properties: {
    partitionCount: 1
    messageRetentionInDays: 1
  }
}
output eventHubIdIothub2asadigitallab string = event_hub_iothub2asadigitallab.id


param event_hub_iothub2asaenrichmessage_name string = 'iothub2asaenrichmessage'
resource event_hub_iothub2asaenrichmessage 'Microsoft.EventHub/namespaces/eventhubs@2017-04-01' = {
  name: concat(event_hub_namespace.name, '/', event_hub_iothub2asaenrichmessage_name)
  properties: {
    partitionCount: 1
    messageRetentionInDays: 1
  }
}
output eventHubIdIothub2asaenrichmessage string = event_hub_iothub2asaenrichmessage.id

param storage_account_name string = 'str${uniqueString(resourceGroup().id)}'
resource storage_account 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
output storageId string = storage_account.id

param storage_account_blob_container_name_rawdata string = 'iothubrawdata'
resource storage_account_blob_container_rawdata 'Microsoft.Storage/storageAccounts/blobServices/containers@2020-08-01-preview' ={
name: '${storage_account.name}/default/${storage_account_blob_container_name_rawdata}'
}

param storage_account_blob_container_name_twinchanges string = 'iothubtwinchanges'
resource storage_account_blob_container_twinchanges 'Microsoft.Storage/storageAccounts/blobServices/containers@2020-08-01-preview' ={
name: '${storage_account.name}/default/${storage_account_blob_container_name_twinchanges}'
}


param iot_hub_name string = 'iot-${uniqueString(resourceGroup().id)}'
resource iothub 'Microsoft.Devices/IotHubs@2020-04-01' = {
  name: iot_hub_name
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}
output iothubId string = iothub.id

resource iot_hub_diagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
  name: diagnostic_settings_name
  scope: iothub
  properties: {
    workspaceId: log_analytics.id
    logAnalyticsDestinationType: 'Dedicated'
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        category: 'Connections'
        enabled: true
      }
      {
        category: 'DeviceTelemetry'
        enabled: true
      }
      {
        category: 'C2DCommands'
        enabled: true
      }
      {
        category: 'DeviceIdentityOperations'
        enabled: true
      }
      {
        category: 'FileUploadOperations'
        enabled: true
      }
      {
        category: 'Routes'
        enabled: true
      }
      {
        category: 'D2CTwinOperations'
        enabled: true
      }
      {
        category: 'C2DTwinOperations'
        enabled: true
      }
      {
        category: 'TwinQueries'
        enabled: true
      }
      {
        category: 'JobsOperations'
        enabled: true
      }
      {
        category: 'DirectMethods'
        enabled: true
      }
      {
        category: 'DistributedTracing'
        enabled: true
      }
      {
        category: 'Configurations'
        enabled: true
      }
      {
        category: 'DeviceStreams'
        enabled: true
      }
    ]
  }
}

param iot_hub_provisioning_service_name string = 'iot-ps-${uniqueString(resourceGroup().id)}'
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

resource iotps_diagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
  name: diagnostic_settings_name
  scope: iotps
  properties: {
    workspaceId: log_analytics.id
    logAnalyticsDestinationType: 'Dedicated'
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        category: 'DeviceOperations'
        enabled: true
      }
      {
        category: 'ServiceOperations'
        enabled: true
      }
    ]
  }
}

param stream_analytics_job_name string = 'asa-${uniqueString(resourceGroup().id)}'
resource stream_analytics_job 'Microsoft.StreamAnalytics/streamingjobs@2017-04-01-preview' = {
  name: stream_analytics_job_name
  location: location
  properties: {
    sku: {
      name: 'Standard'
    }
  }
}

resource stream_analytics_job_diagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
  name: diagnostic_settings_name
  scope: stream_analytics_job
  properties: {
    workspaceId: log_analytics.id
    logAnalyticsDestinationType: 'Dedicated'
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        category: 'Execution'
        enabled: true
      }
      {
        category: 'Authoring'
        enabled: true
      }
    ]
  }
}
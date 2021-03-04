#!/bin/bash
az deployment sub create  --location westeurope --template-file .\policy.json --parameters "@policy.parameters.json"
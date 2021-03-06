#! /bin/bash
CLIENT_SECRET=$1
ACCESS_KEY=$2
CLIENT_ID=$3
TENANT_ID=$4

az login --service-principal -u $CLIENT_ID --password $CLIENT_SECRET  --tenant $TENANT_ID

terraform init -backend-config="access_key=$ACCESS_KEY"

az login --service-principal -u $CLIENT_ID --password $CLIENT_SECRET  --tenant $TENANT_ID
terraform plan -out state.plan -var "access_key=$ACCESS_KEY"

az login --service-principal -u $CLIENT_ID --password $CLIENT_SECRET  --tenant $TENANT_ID
terraform apply "state.plan"

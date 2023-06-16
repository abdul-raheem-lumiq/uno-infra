#!/bin/sh
DB_ENDPOINT=$(aws rds describe-db-instances --db-instance-identifier $IDENTIFIER --region ap-south-1 --output json --query DBInstances[0].Endpoint.Address | tr -d '"')
echo $DB_ENDPOINT
DB_PORT=$(aws rds describe-db-instances --db-instance-identifier $IDENTIFIER --region ap-south-1 --output json --query DBInstances[0].Endpoint.Port | tr -d '"')
echo $DB_PORT
MASTER_USERNAME=$(aws rds describe-db-instances --db-instance-identifier $IDENTIFIER --region ap-south-1 --output json --query DBInstances[0].MasterUsername | tr -d '"')
echo $MASTER_USERNAME
CONNECT_DB=$(aws rds describe-db-instances --db-instance-identifier $IDENTIFIER --region ap-south-1 --output json --query DBInstances[0].DBName | tr -d '"')
echo $CONNECT_DB
cd ../temp-modules/
sed "s/_HOST_/$DB_ENDPOINT/g" ../modules/postgres_db_manifest/provider.tf > postgres_db_manifest/provider.tf
sed -i "s/_PORT_/$DB_PORT/g" postgres_db_manifest/provider.tf #> postgres_db_manifest/provider.tf
sed -i "s/_DATABASE_/$CONNECT_DB/g" postgres_db_manifest/provider.tf
sed -i "s/_USERNAME_/$MASTER_USERNAME/g" postgres_db_manifest/provider.tf
sed -i "s/_PASSWORD_/$PASSWORD/g" postgres_db_manifest/provider.tf
sed "s/_DBNAME_/$DBNAME/g" ../modules/postgres_db_manifest/main.tf > postgres_db_manifest/main.tf
echo $PASSWORD
echo $DBNAME
cd postgres_db_manifest
rm -rf .terraform
rm -rf .terraform.lock.hcl
rm -rf terraform.tfstate
terraform init --reconfigure
terraform apply --auto-approve
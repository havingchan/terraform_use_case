#!/bin/bash

DIR=$PWD
echo $DIR

cd $DIR/vpc
terraform init
terraform apply -auto-approve

cd $DIR/sg
terraform init
terraform apply -auto-approve

cd $DIR/subnet
terraform init
terraform apply -auto-approve

cd $DIR/rds
terraform init
terraform apply -auto-approve

cd $DIR/igw
terraform init
terraform apply -auto-approve

cd $DIR/natgw
terraform init
terraform apply -auto-approve

cd $DIR/lb
terraform init
terraform apply -auto-approve

cd $DIR/asg
terraform init
terraform apply -auto-approve

cd $DIR

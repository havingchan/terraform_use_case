#!/bin/bash

DIR=$PWD
echo $DIR

cd $DIR/asg
terraform destroy -auto-approve

cd $DIR/lb
terraform destroy -auto-approve

cd $DIR/natgw
terraform destroy -auto-approve

cd $DIR/igw
terraform destroy -auto-approve

cd $DIR/rds
terraform destroy -auto-approve

cd $DIR/subnet
terraform destroy -auto-approve

cd $DIR/sg
terraform destroy -auto-approve

cd $DIR/vpc
terraform destroy -auto-approve

cd $DIR
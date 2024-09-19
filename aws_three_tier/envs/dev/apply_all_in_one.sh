#!/bin/bash

terraform apply --auto-approve -target=module.sg
terraform apply --auto-approve -target=module.subnet_web1
terraform apply --auto-approve -target=module.subnet_web2
terraform apply --auto-approve -target=module.subnet_app1
terraform apply --auto-approve -target=module.subnet_app2
terraform apply --auto-approve -target=module.subnet_db1
terraform apply --auto-approve -target=module.subnet_db2
terraform apply --auto-approve -target=module.igw
terraform apply --auto-approve -target=module.natgw1
terraform apply --auto-approve -target=module.natgw2
terraform apply --auto-approve -target=module.app_tier_internal_lb
terraform apply --auto-approve -target=module.web_tier_external_lb
terraform apply --auto-approve -target=module.app_tier_asg
terraform apply --auto-approve -target=module.web_tier_asg
terraform apply --auto-approve -target=module.rds
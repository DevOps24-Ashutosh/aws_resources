#!/bin/bash

###################
# 
# Author: Ashutosh
# Date: 27/08/24
# 
# This script will list out the aws resources 
# version: v1
# 
###################

# script will run in debug mode
set -x

touch cron

# list out ec2instances
aws ec2 describe-instances --region ap-south-1 | jq '.Reservations[].Instances[].InstanceId'

# list out s3
x=$(aws s3 ls | awk -F" " '{print $3}')
echo $x
# aws s3 rb s3://$x --force
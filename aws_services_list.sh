#!/bin/bash

##################################################################
# Author: Ashutosh
# Date: 28/08/24
# version: v0.1

# Script to automate the process of listing all the resources in an AWS account.
 
# Below are the services that are supported by the AWS services
# 1.EC2
# 2.EBS
# 3.RDS
# 4.DynamoDB
# 5.Lambda
# 6.S3
# 7.ELB
# 8.CloudFront
# 9.SNS
# 10.SQS
# 11.Route53
# 12.VPC
# 13.CloudFormation
# 14.IAM
# 15.CloudWatch

# This script will prompt the user enter the region and service for which the resources need to be listed

# Usuage: ./aws_services_list.sh <aws_region_name> <aws_service>
# Example: ./aws_services_list.sh ap-south-1 ec2
#################################################################

# set -x

# Check if the required number of arguments are passed
if [ $# -ne 2 ]; then
    echo "Usuage: ./aws_services_list.sh <aws_region_name> <aws_service>"
    echo "Example: ./aws_services_list.sh ap-south-1 ec2"
    exit 1
fi

# Assign the arguments to variables and conver the services to lower case
aws_region=$1
aws_service=$2

# Check if the aws cli is installed
if ! command -v aws &> /dev/null; then
    echo "AWS cli is not installed. Please install the aws cli and try again"
    exit 1
fi

# Check if the AWS cli is configured
if [ ! -d ~/.aws ]; then
    echo "AWS Cli is not configured"
    exit 1
fi

# List the resources based on services
case $aws_service in
    ec2)
        echo "Listing AWS service in $aws_region"
        aws ec2 describe-instances --region $aws_region | jq -s | grep InstanceId
        ;;

    ebs)
        echo "Listing EBS"
        aws ec2 describe-volumes --region $aws_region | grep InstanceId
        ;;

    rds)
        echo "Listing RDS instances"
        aws rds describe-db-instances --region $aws_region
        ;;

    dynamodb)
        echo "Listing dynamodb tables"   
        aws dynamodb list-tables --region $aws_region
        ;;

    lambda)
        echo "Listing lambda functions"
        aws lambda list-functions --region $aws_region
        ;;

    s3)
        echo "List s3 services"
        aws s3 ls --region $aws_region
        ;;

    elb)
        echo "List elbs"
        aws elb describe-load-balancers --region $aws_region
        ;;

    cloudfront)
        echo "Listing cloudfront distributions"
        aws cloudfront list-distributions --region $aws_region
        ;;

    sns)
        echo "listing all sns"
        aws sns list-topics --region $aws_region
        aws sns list-subscriptions --region $aws_region
        ;;

    sqs)
        echo "listing all queues"
        aws sqs list-queues --region $aws_region
        ;;

    route53)
        echo "listing all route"
        aws route53 list-hosted-zones --region $aws_region
        ;;

    vpc)
        echo "listing all vpcs"
        aws ec2 describe-vpcs --region $aws_region | grep VpcId
        ;;

    cloudformation)
        echo "listing all stacks"
        aws cloudformation describe-stacks --region $aws_region | grep StackName
        ;;

    iam)
        echo "Listing all users, roles"
        aws iam list-roles --region $aws_region | grep RoleName
        aws iam list-users --region $aws_region | grep UserName
        ;;

    cloudwatch)
        echo "Listing cloudwatch dashboards"
        aws cloudwatch list-dashboards --region $aws_region
        aws cloudwatch describe-alarms --region $aws_region
        ;;

    *)
        echo "Invalid service. Please enter a valid service"
        exit 1
        ;;
esac
        
#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-059eb64c5a56f1a51" #REPLACE with your SG ID

for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-059eb64c5a56f1a51 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)

    #to get private ip
    if [ $instance -ne "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids i-0c0f85754095c5c15 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids i-0c0f85754095c5c15 --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
    fi

    echo "$instance: $IP"
done
#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-059eb64c5a56f1a51" 
ZONE_ID="Z08769191SZ0EERXMPHL9"
DOMAIN_NAME="jayani23.fun"
for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)

    #to get private ip
    if [ $instance != "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
        RECORD_NAME="$instance.$DOMAIN_NAME" # mongodb.jayani23.fun
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
        RECORD_NAME="$instance.$DOMAIN_NAME" # jayani23.fun
    fi

    echo "$instance: $IP"

    aws route53 change-resource-record-sets \
        --hosted-zone-id $ZONE_ID \
        --change-batch '
        {
            "Comment": "Updating record set"
            ,"Changes": [{
            "Action"                 : "UPSERT"
		    , "ResourceRecordSet"    : {
		            "Name"			 : "'$RECORD_NAME'"
		            "Type"			 : "A"
		            "TTL"			 : 1
		            "ResourceRecords": [{
				        "Value"    	 : "'$IP'"
                    }]
            }
            }]
        }
        '
done
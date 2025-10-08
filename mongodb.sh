#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-roboshop"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" 

mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: $N Please run this script with root privilage"
    exit 1 # failure is other than 0
fi

VALIDATE(){ # functions receive inputs through args
    if [ $1 -ne 0 ]; then
        echo -e "$2... $R is failure $N" | tee -a $LOG_FILE
    exit 1
    else
        echo -e "$2 ... $G success $N" | tee -a $LOG_FILE
    fi
}

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Adding Mongo repo"

dnf install mongodb-org -y &>>LOG_FILE
VALIDATE $? "Installing MongoDB"

systemctl enable mongodb &>>$LOG_FILE
VALIDATE $? "Enable MongoDB"

systemctl start mongodb
VALIDATE $? "Start MongoDB"
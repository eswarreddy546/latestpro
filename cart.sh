#!/bin/bash

trap 'echo "Error at line $LINENO: command exited with status $?"' ERR

userid=$(id -u)

if [ $userid -ne 0 ]; then

Dir=$(pwd)

echo "error : you have not root privelage acess"

else
echo :"sucessfully excuted command"
fi

valid() {

    if [ $1 -ne 0 ]; then
    echo : "Not Excuted the $2 command"

    else 

        echo : "Sucessfully $2 excuted command"
    fi

}
dnf module disable nodejs -y
valid $? "disable nodejs"

dnf module enable nodejs:20 -y
valid $? "enable nodejs"


dnf install nodejs -y
valid $? "Install nodejs"

useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
$Dir
mkdir /app 


curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip

$Dir
cd /app 

rm -rf /app/*
VALIDATE $? "Removing existing code"

unzip /tmp/cart.zip
valid $? "unzip the file"
$Dir
cd /app 

npm install 
valid $? "npm is sucessfully installed"



systemctl daemon-reload
valid $? "daemon-reload"


systemctl enable cart 
valid $? "enable cart "

systemctl start cart
valid $? "startcart"


cp cart.service/etc/systemd/system/cart.service
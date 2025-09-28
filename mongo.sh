#!/bin/bash
userid=$(id -u)

if [ $userid -ne 0 ]; then

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


cp mongo.repo/vim /etc/yum.repos.d/mongo.repo
valid $? "sucessfully moveed the daata"


dnf install mongodb-org -y 
valid $? "insall mongodb"

systemctl enable mongod 
valid $? "enable mongodb"


systemctl start mongod 
valid $? "start mongodb"

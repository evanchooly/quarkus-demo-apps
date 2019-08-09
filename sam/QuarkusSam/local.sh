#! /bin/sh

set -e 

[[ "$DEBUG" ]] && OPTIONS="--debug-port 5005"
clear
mvn clean

qinstall extensions/amazon-lambda-resteasy
sam build 
sam local start-api ${OPTIONS} &
echo $! > sam.pid

sleep 3
echo
echo
echo

curl -s \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{ "firstName":"Jim", "lastName" : "Halpert" }' \
    http://localhost:3000/greeting/bye

curl -s \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{ "firstName":"Jim", "lastName" : "Halpert" }' \
    http://localhost:3000/greeting/hello

echo
echo
echo

kill -9 `cat sam.pid` && rm sam.pid

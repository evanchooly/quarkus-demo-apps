#! /bin/sh

set -e

if [ "$DEBUG" ]
then
  OPTIONS="--debug --debug-port 5005"
fi

clear
mvn clean

qinstall extensions/amazon-lambda-http
sam build --debug
sam local start-api ${OPTIONS} &
echo $! > sam.pid

sleep 3
echo "\n\n\n"

curl -s \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{ "firstName":"Jim", "lastName" : "Halpert" }' \
    http://localhost:3000/greeting/hello

echo "\n\n\n"

curl -s \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{ "firstName":"Jim", "lastName" : "Halpert" }' \
    http://localhost:3000/greeting/bye
echo

kill -9 $(cat sam.pid) && rm sam.pid

#! /bin/sh

set -e

if [ "$DEBUG" ]
then
  OPTIONS="--debug --debug-port 5005"
fi

clear

killsam.sh &
qinstall extensions/amazon-lambda-http
mvn clean install
#sam build --template sam.jvm.yaml ## --debug
sam local start-api --template sam.jvm.yaml ${OPTIONS} &
echo $! > sam.pid

sleep 3
echo "\n\n\n"

curl -s http://localhost:3000/hello

echo "\n\n\n"

curl -s \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{ "firstName":"Jim", "lastName" : "Halpert" }' \
    http://localhost:3000/hello

echo "\n\n\n"

curl -s \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{ "firstName":"Jim", "lastName" : "Halpert" }' \
    http://localhost:3000/hello/bye
echo

kill -9 $(cat sam.pid) && rm sam.pid

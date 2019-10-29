#! /bin/sh

set -e

TEMPLATE=sam.jvm.yaml

if [ "$DEBUG" ]
then
  OPTIONS="--debug --debug-port 5005"
fi
if [ "$NATIVE" ]
then
  TEMPLATE=sam.native.yaml
  MAVEN_FLAGS="-Pnative -Dnative-image.docker-build=true"
fi

clear

qinstall extensions/amazon-lambda-http

mvn clean package ${MAVEN_FLAGS}
sam local start-api --template ${TEMPLATE} ${OPTIONS} &
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

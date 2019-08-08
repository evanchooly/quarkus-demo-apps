#!/usr/bin/env bash

set -e
REGION="--region us-east-2"
STACK="quarkus-sam"

waitForDelete() {
    echo "Waiting for delete to complete"
    aws cloudformation wait stack-delete-complete --stack-name ${STACK}
}

sam build

#aws s3 mb s3://quarkus-functions

echo "### Packaging"
sam package \
    --output-template-file packaged.yaml \
    --s3-bucket quarkus-functions

echo "### Deploying"
aws cloudformation delete-stack --stack-name ${STACK}
waitForDelete

sam deploy \
    --template-file packaged.yaml \
    --stack-name ${STACK} \
    --capabilities CAPABILITY_IAM \
    ${REGION}

aws cloudformation describe-stack-resources \
    --stack-name ${STACK} \
    --query 'StackResources[?LogicalResourceId=='ServerlessRestApi']'

PHYSICAL=`aws cloudformation describe-stack-resources \
    --stack-name ${STACK} \
    --query "StackResources[?LogicalResourceId=='ServerlessRestApi'].PhysicalResourceId | [0]" | sed -e 's/"//g'`

curl -s \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{ "firstName":"Jim", "lastName" : "Halpert" }' \
    https://${PHYSICAL}.execute-api.us-east-2.amazonaws.com/Prod/greeting/hello

curl -s \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{ "firstName":"Jim", "lastName" : "Halpert" }' \
    https://${PHYSICAL}.execute-api.us-east-2.amazonaws.com/Prod/greeting/bye

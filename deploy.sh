#!/usr/bin/env bash


sam build

#aws s3 mb s3://quarkus-functions

sam package \
    --output-template-file packaged.yaml \
    --s3-bucket quarkus

sam deploy \
    --template-file packaged.yaml \
    --stack-name quarkus-sam \
    --capabilities CAPABILITY_IAM

#aws cloudformation delete-stack \
#    --stack-name quarkus-sam

aws cloudformation describe-stacks \
    --stack-name quarkus-sam \
    --query 'Stacks[].Outputs'
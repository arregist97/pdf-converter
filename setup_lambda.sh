#!/bin/bash
# Creates Lambda function with empty role and image. NOTE: Change the role permissions manually.
REGION=us-east-1
NAME=pdf-encoder
ACCOUNT_ID=""
aws iam create-role --role-name lambda-$NAME-role --assume-role-policy-document file://roles/trust-policy.json
sleep 10
var=`aws ecr describe-repositories --repository-names $NAME --query 'repositories[0].repositoryUri' --output text`
aws lambda create-function --function-name $NAME --package-type Image --code ImageUri=$var:latest --role arn:aws:iam::$ACCOUNT_ID:role/lambda-$NAME-role
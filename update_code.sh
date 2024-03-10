#!/bin/bash
# Update the code of the lambda function by uploading a new image.
REGION=us-east-1
NAME=pdf-encoder
ACCOUNT_ID=""
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
var=`aws ecr describe-repositories --repository-names $NAME --query 'repositories[0].repositoryUri' --output text`
docker build -t $NAME .
docker tag $NAME:latest $var:latest
docker push $var:latest
aws lambda update-function-code --function-name $NAME --image-uri $var:latest
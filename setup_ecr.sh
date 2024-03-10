#!/bin/bash
# Creates a new Container Registry for the Lambda function images.
REGION=us-east-1
NAME=pdf-encoder
ACCOUNT_ID=""
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
aws ecr delete-repository --repository-name $NAME --no-force
var=`aws ecr create-repository --repository-name $NAME --query 'repository.repositoryUri' --output text`
docker build -t $NAME .
docker tag $NAME:latest $var:latest
docker push $var:latest
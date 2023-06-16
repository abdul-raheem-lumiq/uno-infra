#!/bin/bash
aws eks update-kubeconfig --region $REGION_CODE --name $CLUSTER_NAME
CLUSTER_ARN=$(aws eks describe-cluster --name $CLUSTER_NAME --region $REGION_CODE --query cluster.arn | tr -d '"')
echo $CLUSTER_ARN
kubectl config use-context $CLUSTER_ARN
kubectl get ns 
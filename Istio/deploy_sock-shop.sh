#!/bin/bash
cd /home/kube/CNCF-Demo/Istio
kubectl apply -f microservices-demo/deploy/kubernetes/complete-demo.yaml
#kubectl apply -f gateway.yml
kubectl apply -f DestinationRule-All.yaml
kubectl apply -f VirtualService-All.yaml

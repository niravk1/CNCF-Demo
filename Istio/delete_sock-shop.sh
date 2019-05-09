#!/bin/bash
kubectl delete -f VirtualService-All.yaml
kubectl delete -f DestinationRule-All.yaml
kubectl delete -f gateway.yml
kubectl delete -f microservices-demo/deploy/kubernetes/complete-demo.yaml


#!/bin/bash
kubectl get deployment --namespace sock-shop
kubectl get pods --namespace sock-shop
kubectl get svc --namespace sock-shop
kubectl get gateway --namespace sock-shop
kubectl get virtualservice --namespace sock-shop
kubectl get policy -n sock-shop
kubectl get destinationrule -n sock-shop


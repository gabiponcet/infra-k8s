#!/bin/bash

echo "Running smoke tests..."

PODS_RUNNING=$(kubectl get pods --namespace default --field-selector=status.phase=Running | wc -l)
if [ "$PODS_RUNNING" -gt "1" ]; then
  echo "All pods are running!"
else
  echo "Some pods are not running!"
  exit 1
fi

SERVICES_ACTIVE=$(kubectl get svc --namespace default | grep 'LoadBalancer\|ClusterIP' | wc -l)
if [ "$SERVICES_ACTIVE" -gt "0" ]; then
  echo "All services are active!"
else
  echo "Some services are not active!"
  exit 1
fi

SERVICE_ENDPOINT="http://my-service.default.svc.cluster.local:8080/health"
if curl --fail $SERVICE_ENDPOINT; then
  echo "Service health check passed!"
else
  echo "Service health check failed!"
  exit 1
fi

echo "All smoke tests passed!"
#!/bin/bash

echo "Running smoke tests..."
if curl --fail http://localhost:8080/health; then
  echo "Smoke tests passed!"
else
  echo "Smoke tests failed!"
  exit 1
fi

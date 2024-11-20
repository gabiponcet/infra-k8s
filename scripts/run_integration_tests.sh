#!/bin/bash

echo "Running integration tests..."

echo "Installing Go and Terratest dependencies..."
sudo apt-get update
sudo apt-get install -y golang-go

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

cd terratest

echo "Running Terratest integration tests..."
go mod tidy
go test -v

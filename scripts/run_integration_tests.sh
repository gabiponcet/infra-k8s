#!/bin/bash

echo "Running integration tests..."

# Garantir permissões de execução para os scripts
chmod +x ./scripts/*.sh

# Instalar Go e Terratest
echo "Installing Go and Terratest dependencies..."
sudo apt-get update
sudo apt-get install -y golang-go

# Configurar o ambiente Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Ir para o diretório de testes
cd terratest

# Rodar os testes Terratest
echo "Running Terratest integration tests..."
go mod tidy
go test -v
# Infraestrutura Kubernetes com Terraform

## Visão Geral

Este repositório contém a configuração de infraestrutura para um cluster Kubernetes utilizando Terraform. 
Além disso, ele emula serviços da AWS utilizando LocalStack para testar e provisionar recursos como Lambda, API Gateway, CognitoID, S3 e IAM Roles.

## Estrutura do Repositório

- **`terraform/`**: Diretório contendo os arquivos de configuração do Terraform.
- **`k8s/`**: Diretório contendo os manifests do Kubernetes para recursos globais.
- **`.github/workflows/`**: Diretório contendo os workflows de CI/CD para o GitHub Actions.

## Pré-requisitos

- Docker instalado e em execução
- LocalStack instalado (`pip install localstack`) ou rodar diretamente pelo Docker
- Terraform instalado (`brew install terraform` ou [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli))

## Configuração

### Iniciar LocalStack

1. Caso esteja utilizando Docker, primeiro crie um volume:
   ```bash
   docker volume create localstack_data

2. Em seguida, rode o LocalStack pelo Docker:
   ```bash
   docker run --rm -it -e LOCALSTACK_API_KEY="test" -e LOCALSTACK_HOST="localhost" -e DOCKER_HOST="unix:///var/run/docker.sock" -e LOCALSTACK_SERVICES="lambda,s3,iam,apigateway" -v /var/run/docker.sock:/var/run/docker.sock -p 4566:4566 -p 4571:4571 localstack/localstack

3. No terminal, configure as variáveis AWS:
   ```bash
   aws configure

4. Teste a criação de um bucket:
   ```bash
   aws --endpoint-url=http://localhost:4566 s3 mb s3://test-bucket

5. Listar buckets:
   ```bash
   aws --endpoint-url=http://localhost:4566 s3 ls

### Terraform
1. No PowerShell (ou terminal de sua escolha), após o Terraform estar devidamente instalado e configurado, navegue até a pasta terraform:
   ```bash
   cd terraform

2. Execute o comando para inicializar o Terraform:
   ```bash
   terraform init

3. Em seguida, execute o comando para aplicar as configurações e criar toda a infraestrutura necessária:
   ```bash
   terraform apply -auto-approve

### Executar CI/CD Pipeline
Certifique-se de que os segredos necessários (DOCKER_USERNAME, DOCKER_PASSWORD, GITHUB_TOKEN) estão configurados no GitHub. Ao fazer um push ou criar um pull request, o workflow CI/CD será acionado automaticamente e provisionará a infraestrutura.

### Monitoramento
Monitorar os logs do LocalStack:
   ``bash
    `docker logs localstack_main`

### CI/CD Pipeline

### Descrição

Este repositório utiliza GitHub Actions para provisionar infraestrutura usando Terraform.

### Estrutura do Pipeline

1. **Verificação de Código**:
- Validação do código Terraform (`terraform validate`)
- Verificação de formatação (`terraform fmt -check`)

2. **Provisionamento**:
- Inicialização do Terraform (`terraform init`)
- Aplicação do Terraform (`terraform apply -auto-approve`)

3. **Implantação**:
- Criação e atualização de deployments em ambientes de staging e produção

4. **Rollback**:
- Rollback automático em caso de falha durante a aplicação do Terraform

### Passos para Recuperação

Caso o pipeline falhe, siga estes passos:
1. Verifique os logs do GitHub Actions para identificar o problema.
2. Utilize a etapa de rollback para reverter mudanças, se necessário.
3. Corrija os problemas e reinicie o pipeline.


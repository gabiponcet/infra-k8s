package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/gruntwork-io/terratest/modules/k8s"
    "github.com/stretchr/testify/assert"
)

func TestKubernetesDeployment(t *testing.T) {
    // Configurar as opções do Terraform
    terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
        TerraformDir: "../../terraform",
    })

    // Aplicar e destruir a infraestrutura ao final
    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)

    // Configurar as opções do Kubectl
    kubectlOptions := k8s.NewKubectlOptions("", "", "lanchonete-namespace")

    // Verificar se o namespace foi criado
    namespace := k8s.GetNamespace(t, kubectlOptions, "lanchonete-namespace")
    assert.NotNil(t, namespace)

    // Verificar se o deployment foi criado e está rodando
    deployment := k8s.GetDeployment(t, kubectlOptions, "lanchonete-deployment")
    assert.Equal(t, int32(2), *deployment.Spec.Replicas)
}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.4.5"

  values = [
    file("${path.module}/../configs/helm-values.yaml")
  ]

  wait    = true
  timeout = 900
}
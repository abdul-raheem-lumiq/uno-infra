provider "kubernetes" {
  config_path    = "~/.kube/config"
  #config_context = "drishti-dev"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
# For Argo and such
resource "digitalocean_spaces_bucket" "minio" {
  name   = var.spaces_bucket
  region = "nyc3"
}

resource "kubernetes_secret" "spaces_secret" {
  metadata {
    name = "spaces-secret"
    namespace = var.namespace
  }

  data = {
    "endpoint"  = "https://${digitalocean_spaces_bucket.minio.region}.digitaloceanspaces.com"
    "accessKey" = var.spaces_key
    "secretKey" = var.spaces_secret
  }
}

resource "random_string" "accesskey" {
  length           = 32
  special          = false
}

resource "random_string" "secretkey" {
  length           = 32
  special          = false
}

resource "kubernetes_secret" "minio_secret" {
  metadata {
    name = "minio-gateway-secret"
    namespace = var.namespace
  }

  data = {
    "root-user" = random_string.accesskey.result
    "root-password" = random_string.secretkey.result
    "access-key" = random_string.accesskey.result
    "secret-key" = random_string.secretkey.result
  }
}

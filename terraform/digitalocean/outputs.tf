output "minio_secret_name" {
  value = kubernetes_secret.minio_gateway_secret.name
}

output "spaces_secret_name" {
  value = kubernetes_secret.spaces_secret.name
}

output "accesskey" {
  value = random_string.accesskey.result
}

output "secretkey" {
  value = random_string.secretkey.result
}

output "minio_secret_name" {
  value = kubernetes_secret.minio_secret.metadata.name
}

output "spaces_secret_name" {
  value = kubernetes_secret.spaces_secret.metadata.name
}

output "accesskey" {
  value = random_string.accesskey.result
}

output "secretkey" {
  value = random_string.secretkey.result
}

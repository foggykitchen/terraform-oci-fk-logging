output "cluster" {
  value = module.oke.cluster
}

output "logging" {
  value = module.logging.service_logs
}

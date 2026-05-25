output "compute_instance_id" {
  value = module.compute.instance_id
}

output "vcn_subnet_id" {
  value = module.vcn.subnet_ids["public"]
}

output "logging" {
  value = module.logging.service_logs
}

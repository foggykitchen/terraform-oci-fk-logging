output "log_group_id" {
  description = "OCI Logging log group OCID."
  value       = local.resolved_log_group_id
}

output "created_log_group_id" {
  description = "OCI Logging log group OCID when the module created it."
  value       = try(oci_logging_log_group.this[0].id, null)
}

output "log_group_name" {
  description = "Display name of the created OCI Logging log group."
  value       = try(oci_logging_log_group.this[0].display_name, null)
}

output "service_log_ids" {
  description = "Map of OCI Logging service log OCIDs keyed by service_logs map key."
  value       = { for key, log in oci_logging_log.service : key => log.id }
}

output "service_logs" {
  description = "Structured summary of created OCI Logging service logs."
  value = {
    for key, log in oci_logging_log.service : key => {
      id           = log.id
      display_name = log.display_name
      log_group_id = log.log_group_id
      log_type     = log.log_type
      is_enabled   = log.is_enabled
    }
  }
}

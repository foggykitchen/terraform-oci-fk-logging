locals {
  resolved_log_group_id = var.create_log_group ? oci_logging_log_group.this[0].id : var.log_group_id
}

resource "oci_logging_log_group" "this" {
  count = var.create_log_group ? 1 : 0

  compartment_id = var.compartment_ocid
  display_name   = var.log_group_name
  description    = var.log_group_description
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags

  lifecycle {
    precondition {
      condition     = var.create_log_group || var.log_group_id != null
      error_message = "log_group_id must be provided when create_log_group is false."
    }
  }
}

resource "oci_logging_log" "service" {
  for_each = var.service_logs

  display_name = coalesce(try(each.value.display_name, null), each.key)
  log_group_id = local.resolved_log_group_id
  log_type     = try(each.value.log_type, "SERVICE")
  is_enabled   = try(each.value.is_enabled, true)

  configuration {
    compartment_id = var.compartment_ocid

    source {
      category    = each.value.source.category
      resource    = each.value.source.resource
      service     = each.value.source.service
      source_type = try(each.value.source.source_type, "OCISERVICE")
    }
  }
}

module "logging" {
  source = "../.."

  compartment_ocid      = var.compartment_ocid
  log_group_name        = "compute-network-log-group"
  log_group_description = "VCN Flow Logs for a compute-based environment"

  service_logs = {
    subnet_flow_logs = {
      display_name = "subnet-flow-logs"
      source = {
        category = "subnet"
        service  = "flowlogs"
        resource = module.vcn.subnet_ids["public"]
      }
    }
  }
}

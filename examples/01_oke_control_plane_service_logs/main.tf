module "oke" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-oke.git?ref=v0.1.0"

  tenancy_ocid                  = var.tenancy_ocid
  compartment_ocid              = var.compartment_ocid
  cluster_type                  = "basic"
  k8s_version                   = "v1.35.2"
  node_linux_version            = "8.10"
  node_shape                    = "VM.Standard.A1.Flex"
  node_ocpus                    = 1
  node_memory                   = 4
  use_existing_vcn              = false
  is_api_endpoint_subnet_public = true
  is_lb_subnet_public           = true
  is_nodepool_subnet_public     = true
}

module "logging" {
  source = "../.."

  compartment_ocid      = var.compartment_ocid
  log_group_name        = "oke-log-group"
  log_group_description = "Service logs for OKE control plane"

  service_logs = {
    oke_control_plane = {
      display_name = "oke-control-plane"
      source = {
        category = "all-service-logs"
        service  = "oke-k8s-cp-prod"
        resource = module.oke.cluster.id
      }
    }
  }
}

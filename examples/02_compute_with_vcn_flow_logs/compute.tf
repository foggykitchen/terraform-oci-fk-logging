module "compute" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-compute.git?ref=v0.1.0"

  name             = "fk-logging-vm"
  tenancy_ocid     = var.tenancy_ocid
  compartment_ocid = var.compartment_ocid
  subnet_id        = module.vcn.subnet_ids["public"]

  deployment_mode          = "instance"
  shape                    = "VM.Standard.A1.Flex"
  operating_system_version = "9"
  shape_config = {
    ocpus         = 1
    memory_in_gbs = 6
  }

  assign_public_ip = true
}

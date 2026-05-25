module "vcn" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-vcn.git?ref=v0.1.0"

  compartment_ocid = var.compartment_ocid
  name             = "fk-compute-vcn"
  vcn_cidr_blocks  = ["10.20.0.0/16"]
  dns_label        = "fkvcn"

  create_internet_gateway = true
  create_nat_gateway      = false
  create_service_gateway  = true

  route_tables = {
    public = {
      display_name = "fk-public-rt"
      route_rules = [
        {
          description        = "Traffic to/from internet"
          destination        = "0.0.0.0/0"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "internet_gateway"
        }
      ]
    }
  }

  security_lists = {
    public = {
      display_name = "fk-public-sl"
      ingress_rules = [
        {
          description = "SSH"
          protocol    = "6"
          source      = "0.0.0.0/0"
          source_type = "CIDR_BLOCK"
          tcp_options = {
            min = 22
            max = 22
          }
        }
      ]
      egress_rules = [
        {
          description      = "All outbound"
          protocol         = "all"
          destination      = "0.0.0.0/0"
          destination_type = "CIDR_BLOCK"
        }
      ]
    }
  }

  subnets = {
    public = {
      cidr_block                    = "10.20.10.0/24"
      display_name                  = "fk-public-subnet"
      dns_label                     = "pubsub"
      route_table_key               = "public"
      security_list_keys            = ["public"]
      include_default_security_list = false
      prohibit_public_ip_on_vnic    = false
    }
  }
}

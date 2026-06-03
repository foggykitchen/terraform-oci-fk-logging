# terraform-oci-fk-logging

This repository contains a reusable **Terraform/OpenTofu module** and progressive examples for deploying **Oracle Cloud Infrastructure (OCI) Logging** resources as a shared observability layer for OCI services and infrastructure patterns.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and is designed to work cleanly with reusable infrastructure modules such as **`terraform-oci-fk-oke`**, **`terraform-oci-fk-compute`**, and **`terraform-oci-fk-vcn`**.

Support expectations are documented in [SUPPORT.md](SUPPORT.md).

---

## Purpose

The goal of this module is to provide a **clean, composable, and educational reference implementation** for OCI Logging:

- Focused on OCI-native log groups and service logs
- Suitable for OKE, VCN Flow Logs, Load Balancer, Functions, and similar OCI service logging patterns
- Designed for hands-on learning, module composition, and multicloud comparisons

This is **not** a full observability platform. It is a **learning-first, architecture-aware module**.

---

## What the module does

The module creates:

- OCI Logging log group
- One or more OCI Logging service logs
- Optional reuse of an existing log group

The module intentionally does **not** create:

- OCI Logging Analytics resources
- Service Connector pipelines
- dashboards or saved searches
- agent-based custom log collection for compute instances
- alerting policies

Each of those concerns belongs in its own dedicated module or workflow layer.

---

## Repository Structure

```bash
terraform-oci-fk-logging/
├── examples/
│   ├── 01_oke_control_plane_service_logs/
│   ├── 02_compute_with_vcn_flow_logs/
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

All examples are runnable and demonstrate **incremental OCI Logging patterns**, starting from OKE service logs and progressing to VCN Flow Logs used in a compute-based environment.

---

## Example Usage

### OKE control plane service logs

```hcl
module "logging" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-logging.git?ref=v0.1.0"

  compartment_ocid    = var.compartment_ocid
  log_group_name      = "oke-log-group"
  log_group_description = "Service logs for OKE control plane"

  service_logs = {
    oke_control_plane = {
      display_name = "oke-control-plane"
      source = {
        category = "all-service-logs"
        service  = "oke-k8s-cp-prod"
        resource = var.oke_cluster_id
      }
    }
  }
}
```

### VCN Flow Logs in a compute environment

```hcl
module "logging" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-logging.git?ref=v0.1.0"

  compartment_ocid = var.compartment_ocid
  log_group_name   = "network-log-group"

  service_logs = {
    subnet_flow_logs = {
      display_name = "subnet-flow-logs"
      source = {
        category = "subnet"
        service  = "flowlogs"
        resource = var.subnet_id
      }
    }
  }
}
```

---

## Module Inputs

### Core inputs

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `compartment_ocid` | `string` | yes | OCI compartment OCID where the log group and logs are created |
| `create_log_group` | `bool` | no | Whether the module creates a new log group |
| `log_group_id` | `string` | no | Existing log group OCID used when `create_log_group = false` |
| `log_group_name` | `string` | no | Display name for the created log group |
| `log_group_description` | `string` | no | Description for the created log group |
| `service_logs` | `map(object)` | no | Map of OCI service logs to create |
| `defined_tags` | `map(string)` | no | Defined tags |
| `freeform_tags` | `map(string)` | no | Freeform tags |

### `service_logs` object schema

```hcl
service_logs = map(object({
  display_name = optional(string)
  is_enabled   = optional(bool, true)
  log_type     = optional(string, "SERVICE")
  source = object({
    category    = string
    resource    = string
    service     = string
    source_type = optional(string, "OCISERVICE")
  })
}))
```

This structure keeps the module generic across multiple OCI service-log scenarios while staying explicit about resource identity and log source type.

---

## Module Outputs

| Output | Description |
|--------|-------------|
| `log_group_id` | Effective OCI Logging log group OCID |
| `created_log_group_id` | OCI Logging log group OCID when created by the module |
| `log_group_name` | Display name of the created log group |
| `service_log_ids` | Map of service log OCIDs keyed by `service_logs` key |
| `service_logs` | Structured summary of created service logs |

---

## Service Scope And Design Notes

This initial release is intentionally focused on **service logs**.

That makes it a natural fit for:

- OKE control plane logs
- VCN Flow Logs
- Load Balancer logs
- Functions service logs

For **compute instances**, OCI Logging usually becomes an **agent-based custom log** problem rather than a native service-log problem.

That is a valid next evolution for this repository, but it is a distinct pattern and not bundled into the first release.

---

## Examples

Runnable examples are available in [examples](examples/README.md).

They show:

- OKE control plane service logging
- VCN Flow Logs in an environment that also deploys compute resources

This gives the repository one example directly tied to `terraform-oci-fk-oke` and one tied to a compute-based architecture using `terraform-oci-fk-compute` plus `terraform-oci-fk-vcn`.

---

## Contributing

This project is open source. Contributions are welcome through pull requests.

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](LICENSE) for details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.

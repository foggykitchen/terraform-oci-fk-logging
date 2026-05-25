# OCI Logging with Terraform/OpenTofu - Training Examples

This directory contains runnable examples for the **terraform-oci-fk-logging** module.
The examples focus on practical OCI Logging patterns, from OKE control plane service logs to VCN Flow Logs in a compute-based environment.

These examples are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are used across OCI and multicloud courses covering observability, Kubernetes, networking, compute, and architecture fundamentals.

---

## Published Examples

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **OKE Control Plane Service Logs** | OKE, service logs, log groups, `terraform-oci-fk-oke` integration |
| 02 | **Compute Environment with VCN Flow Logs** | VCN Flow Logs, log groups, compute context, `terraform-oci-fk-compute` and `terraform-oci-fk-vcn` integration |

---

## How to Use

The example directory contains:
- Terraform/OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the goal of the example
- A minimal, runnable architecture

To run the OKE logging example:

```bash
cd examples/01_oke_control_plane_service_logs
tofu init
tofu plan
tofu apply
```

To run the compute and VCN Flow Logs example:

```bash
cd examples/02_compute_with_vcn_flow_logs
tofu init
tofu plan
tofu apply
```

---

## Design Principles

- One example = one architectural goal
- No unused or placeholder resources
- Clear separation of concerns between infrastructure creation and logging enablement
- Examples designed to integrate with other modules such as OKE, Compute, and VCN

---

## Related Resources

- [FoggyKitchen OCI Logging Module (terraform-oci-fk-logging)](../)
- [FoggyKitchen OCI OKE Module (terraform-oci-fk-oke)](https://github.com/foggykitchen/terraform-oci-fk-oke)
- [FoggyKitchen OCI Compute Module (terraform-oci-fk-compute)](https://github.com/foggykitchen/terraform-oci-fk-compute)
- [FoggyKitchen OCI VCN Module (terraform-oci-fk-vcn)](https://github.com/foggykitchen/terraform-oci-fk-vcn)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](../LICENSE) for details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.

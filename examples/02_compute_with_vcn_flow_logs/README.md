# Example 02: Compute Environment with VCN Flow Logs

In this second logging example, we deploy a **compute-based OCI environment**
using **Terraform/OpenTofu**, and then enable **VCN Flow Logs** through OCI Logging.

This example deliberately combines:

- `terraform-oci-fk-vcn`
- `terraform-oci-fk-compute`
- `terraform-oci-fk-logging`

to show how OCI Logging fits into a compute-oriented architecture even when the log source itself is the network layer.

---

## Architecture Overview

This deployment creates:

- one **VCN**
- one **public subnet**
- one **regular OCI compute instance**
- one **OCI Logging log group**
- one **VCN Flow Log** on the subnet

This is an important distinction:

- the environment contains compute resources
- the log source is the OCI networking service

That makes this example a realistic observability pattern for compute-based estates
without forcing the module to manage agent-based custom logs in its first release.

---

## Deployment Steps

Initialize and apply the Terraform/OpenTofu configuration:

```bash
tofu init
tofu plan
tofu apply
```

If you prefer Terraform:

```bash
terraform init
terraform plan
terraform apply
```

After a successful deployment, Terraform will output:

- the compute instance OCID
- the subnet OCID used for flow logs
- the created logging resources

---

## Runtime Notes

The resulting flow log is configured with:

- `service = "flowlogs"`
- `category = "subnet"`

This provides a networking-centric observability path for traffic associated with the compute environment.

If you later want OS or application logs from the instance itself, that becomes a **custom logs and agent** pattern,
which is a separate next-step capability for the logging module.

---

## Cleanup

To remove all resources created by this example:

```bash
tofu destroy
```

Or with Terraform:

```bash
terraform destroy
```

---

## Summary

This example demonstrates:

- how to create **VCN Flow Logs** with Terraform/OpenTofu
- how to combine `terraform-oci-fk-logging` with `terraform-oci-fk-vcn`
- how to place logging into a compute-oriented architecture using `terraform-oci-fk-compute`

---

## Learn More

Visit [FoggyKitchen.com](https://foggykitchen.com/) for OCI, multicloud, and Terraform/OpenTofu learning resources.

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](../../LICENSE) for more details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.

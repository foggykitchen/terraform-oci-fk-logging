# Example 01: OKE Control Plane Service Logs

In this first logging example, we deploy a **basic Oracle Kubernetes Engine (OKE) cluster**
and then enable **OCI Logging service logs** for the OKE control plane using **Terraform/OpenTofu**.

This example focuses on the direct service-log pattern where the target resource is an OCI-managed service
and the log is configured through OCI Logging.

---

## Architecture Overview

This deployment creates:

- one **basic OKE cluster**
- one **OCI Logging log group**
- one **OCI Logging service log** targeting the OKE control plane

This is the most direct way to understand how the logging module behaves
in a Kubernetes-oriented OCI service logging scenario.

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

- OKE cluster metadata
- the created logging resources

---

## Runtime Notes

The resulting log is configured with:

- `service = "oke-k8s-cp-prod"`
- `category = "all-service-logs"`

This pattern is service-native and does not require log agent configuration inside worker nodes.

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

- how to create **OCI Logging service logs** for OKE
- how to combine `terraform-oci-fk-logging` with `terraform-oci-fk-oke`
- how to keep cluster provisioning and logging concerns composable

---

## Learn More

Visit [FoggyKitchen.com](https://foggykitchen.com/) for OCI, multicloud, and Terraform/OpenTofu learning resources.

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](../../LICENSE) for more details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.

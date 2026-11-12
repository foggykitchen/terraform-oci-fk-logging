# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_resource "oci_logging_log" {
    defaults = { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_LOG", "state" = "AVAILABLE", "tenancy_id" = "MOCK_OCID_MOCK", "time_created" = "mock-value", "time_last_modified" = "mock-value" }
  }
  mock_resource "oci_logging_log_group" {
    defaults = { "id" = "MOCK_OCID_GROUP", "state" = "AVAILABLE", "time_created" = "mock-value", "time_last_modified" = "mock-value" }
  }
}
variables {
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
}

run "oci9_plan" {
  command = plan
}

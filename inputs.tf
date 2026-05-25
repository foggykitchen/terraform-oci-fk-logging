variable "compartment_ocid" {
  description = "Compartment OCID where the log group and logs are created."
  type        = string
}

variable "create_log_group" {
  description = "Create a new OCI Logging log group. When false, log_group_id must be provided."
  type        = bool
  default     = true
}

variable "log_group_id" {
  description = "Existing OCI Logging log group OCID used when create_log_group is false."
  type        = string
  default     = null
}

variable "log_group_name" {
  description = "Display name for the OCI Logging log group when create_log_group is true."
  type        = string
  default     = "fk-log-group"
}

variable "log_group_description" {
  description = "Optional description for the OCI Logging log group."
  type        = string
  default     = "FoggyKitchen OCI Logging log group"
}

variable "service_logs" {
  description = "Map of OCI service logs to create in the selected log group."
  type = map(object({
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
  default = {}
}

variable "defined_tags" {
  description = "Defined tags applied to the OCI Logging log group."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags applied to the OCI Logging log group."
  type        = map(string)
  default     = {}
}

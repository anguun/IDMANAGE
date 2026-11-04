variable "subscription_id" {
  description = "Azure subscription ID to deploy into."
  type        = string
}

variable "student_name" {
  description = "Your name, lowercase letters and numbers only. Used in resource names."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.student_name))
    error_message = "student_name must use lowercase letters and numbers only."
  }
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "westus2"
}

variable "container_name" {
  description = "Private container the application identity is allowed to use."
  type        = string
  default     = "reports"
}

variable "restricted_container_name" {
  description = "Second private container, used for the negative test (the app identity gets no access)."
  type        = string
  default     = "restricted"
}

variable "create_service_principal" {
  description = "Create the Entra application and service principal (needs permission to register apps)."
  type        = bool
  default     = false
}

variable "assign_blob_role" {
  description = "Give the service principal the blob data role on the reports container. Needs create_service_principal = true."
  type        = bool
  default     = false
}

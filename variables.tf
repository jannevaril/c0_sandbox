variable "customer" {
  default = "jannevaril"
}
variable "environment" {
  default = "c0_sandbox"
}

variable "default-tags" {
  default = {
    "ManagementLevel" = "Managed",
    "Environment"     = "c0_sandbox",
    "ManagedBy"       = "Terraform",
    "CustomerCode"    = "jannevaril",
  }
}
variable "region" {
  default = "eu-north-1"
}
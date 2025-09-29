variable "customer" {
  default = "nevarjan"
}
variable "environment" {
  default = "sandbox"
}

variable "default-tags" {
  default = {
    "ManagementLevel" = "Managed",
    "Environment"     = "infragov",
    "ManagedBy"       = "Terraform",
    "CustomerCode"    = "c",
  }
}
variable "region" {
  default = "eu-north-1"
}
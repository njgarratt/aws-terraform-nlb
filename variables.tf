
variable "nlb_name" {
  description = "A name for the load balancer, which must be unique within your AWS account."
  type        = "string"
}

variable "nlb_tags" {
  description = "A map of tags to be applied to the ALB. i.e {Environment='Development'}"
  type        = "map"
  default     = {}
}

variable "environment" {
  description = "Application environment for which this network is being created. one of: ('Development', 'Integration', 'PreProduction', 'Production', 'QA', 'Staging', 'Test')"
  type        = "string"
  default     = "Development"
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = "string"
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled."
  type = "string"
  default = false
}

variable "subnets" {
  type = "list"
}

variable "allocation_ids" {
  type = "list"
}

variable "subnets_count" {
  type = "string"
}


variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack"
  type = "string"
  default = "ipv4"
}

# Internal has EIP allocs
# External does not
variable "load_balancer_is_internal" {
  description = "Indicates whether the load balancer is Internet-facing or internal. i.e. true | false"
  type        = "string"
  default     = false
}


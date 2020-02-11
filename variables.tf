variable "name" {
  type        = string
  description = "name for this load balancer"
}

variable "environment" {
  type        = string
  default     = "test"
  description = "environment name e.g. dev; prod"
}

variable "create_internal_zone_record" {
  description = "Create Route 53 internal zone record for the NLB. i.e true | false"
  type        = string
  default     = false
}

variable "internal_record_name" {
  description = "Record Name for the new Resource Record in the Internal Hosted Zone. i.e. nlb.example.com"
  type        = string
  default     = ""
}

variable "listener_map_count" {
  description = "The number of listener maps to utilize"
  type        = string
  default     = "1"
}

variable "route_53_hosted_zone_id" {
  type        = string
  default     = ""
  description = "the zone_id in which to create our ALIAS"
}

variable "subnet_ids" {
  type        = list(string)
  description = "list of subnet ids (1 per AZ only) to attach to this NLB"
}

variable "eni_count" {
  default     = "0"
  type        = string
  description = "explicitly tell terraform how many subnets to expect"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_map" {
  type        = map(list(string))
  description = "**not implemented** subnet -> EIP mapping"

  default = {
    "0" = ["eip-1", "subnet-1"]
  }
}

variable "facing" {
  default     = "external"
  type        = string
  description = "is this load-balancer internal or external?"
}

variable "cross_zone" {
  default     = true
  type        = string
  description = "configure cross zone load balancing"
}

variable "tags" {
  type        = map(string)
  description = "tags map"

  default = {}
}

/*  NLB: listener map

e.g.
listener_map = {
  "0" = {
    "certificate_arn" = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-90ab-cdef-1234-567890abcdef>" # Required for the TLS protocol
    "port"            = "80"
    "protocol"        = "TCP" # Defaults to TCP.  Allowed values: TCP, TLS
    "ssl_protocol"    = "ELBSecurityPolicy-TLS-1-2-2017-02" # Optional, to set a specific SSL Policy.
    "target_group"    = "arn:aws:elasticloadbalancing:xxxxxxx" # optionally specify existing TG ARN
  }
}
*/
variable "listener_map" {
  type        = map(map(string))
  description = "listener map"
}

/*
  NLB: target group map

e.g.
tg_map  = {
  "listener1" = {
    "name"          = "listener1-tg-name"
    "port"          = "80"
    "dereg_delay"   = "300"
    "target_type"   = "instance"
  }
}
*/
variable "tg_map" {
  type        = map(map(string))
  description = "target group map"
}

/* NLB: tg health checks
e.g.
hc_map  = {
  "listener1" = {
      protocol            = "TCP"
      healthy_threshold   = "3"
      unhealthy_threshold = "3"
      interval            = "30"
    }
  "listener2" = {
      protocol            = "HTTP"
      healthy_threshold   = "3"
      unhealthy_threshold = "3"
      interval            = "30"
      matcher             = "200-399"
      path                = "/"
    }
}
*/
variable "hc_map" {
  type        = map(map(string))
  description = "health check map"
}

variable "notification_topic" {
  description = "List of SNS Topic ARNs to use for customer notifications."
  type        = list(string)
  default     = []
}

variable "rackspace_managed" {
  description = "Boolean parameter controlling if instance will be fully managed by Rackspace support teams, created CloudWatch alarms that generate tickets, and utilize Rackspace managed SSM documents."
  type        = string
  default     = true
}

variable "rackspace_alarms_enabled" {
  description = "Specifies whether alarms will create a Rackspace ticket.  Ignored if rackspace_managed is set to false."
  type        = string
  default     = false
}


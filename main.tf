
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  env_list = ["Development", "Integration", "PreProduction", "Production", "QA", "Staging", "Test"]
  
  environment = "${contains(local.env_list, var.environment) ? var.environment:"Development"}"

  default_tags = {
    ServiceProvider = "Rackspace"
    Environment     = "${local.environment}"
  }

  subnet_mappings = {
      subnet_0 = []
      subnet_1 = "${list(local.subnet_mapping_1)}"
      subnet_2 = "${list(local.subnet_mapping_1, local.subnet_mapping_2)}"
      subnet_3 = "${list(local.subnet_mapping_1, local.subnet_mapping_2, local.subnet_mapping_3)}"
  }

  # subnet_mapping_1 = {
  #     subnet_id = "${var.subnets[0]}"
  #     allocation_id = "${var.allocation_ids[0]}"
  # }

  # subnet_mapping_2 = {
  #     subnet_id = "${var.subnets[1]}"
  #     allocation_id = "${var.allocation_ids[1]}"
  # }

  # subnet_mapping_3 = {
  #     subnet_id = "${element(var.subnets,2)}"
  #     allocation_id = "${element(var.allocation_ids,2)}"
  # }

  subnet_mapping_1 = "${map(
    "subnet_id", element(var.subnets, 0),
    "allocation_id", element(var.allocation_ids, 0)
  )}"

  subnet_mapping_2 = "${map(
    "subnet_id", element(var.subnets, 1),
    "allocation_id", element(var.allocation_ids, 1)
  )}"

  subnet_mapping_3 = "${map(
    "subnet_id", element(var.subnets, 2),
    "allocation_id", element(var.allocation_ids, 2)
  )}"

  subnet_mappings_lookup = "${var.load_balancer_is_internal ? "subnet_0":"subnet_${var.subnets_count}"}"
  merged_tags = "${merge(local.default_tags, var.nlb_tags)}"
}

resource "aws_lb" "nlb" {

  name = "${var.nlb_name}"
  internal  = "${var.load_balancer_is_internal}"
  load_balancer_type = "network"
  
  #Subnets
  # subnet_mapping = [{
  #     subnet_id = "${var.subnets[0]}"
  #     allocation_id = "${var.allocation_ids[0]}"
  # },
  # {
  #     subnet_id = "${var.subnets[1]}"
  #     allocation_id = "${var.allocation_ids[1]}"
  # }]
  subnet_mapping = ["${local.subnet_mappings[local.subnet_mappings_lookup]}"]
  
      
  

  enable_deletion_protection = "${var.enable_deletion_protection}"
  enable_cross_zone_load_balancing = "${var.enable_cross_zone_load_balancing}"

  ip_address_type = "${var.ip_address_type}"

  tags = "${local.merged_tags}"
}

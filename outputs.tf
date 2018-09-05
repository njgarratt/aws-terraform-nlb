output "subnet_mapping" {
  value = "${local.subnet_mappings[local.subnet_mappings_lookup]}"
}

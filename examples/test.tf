provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

module "vpc" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork//?ref=v0.0.1"

  vpc_name = "Steven-VPC"
}

resource "aws_eip" "one" {
  vpc      = true
}

resource "aws_eip" "two" {
  vpc      = true
}

module "nlb" {
  source = "/home/steven/github/aws-terraform-nlb"
  nlb_name = "testnlb"
  subnets = "${module.vpc.public_subnets}"
  subnets_count = 2
  allocation_ids = ["${aws_eip.one.id}", "${aws_eip.two.id}"]
}

output "subnets" {
  value = "${module.nlb.subnet_mapping}"
}

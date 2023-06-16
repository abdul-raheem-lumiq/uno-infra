resource "aws_subnet" "subnet" {
  availability_zone = var.availability_zone
  cidr_block = var.cidr_block
  enable_resource_name_dns_a_record_on_launch = var.enable_resource_name_dns_a_record_on_launch
  map_public_ip_on_launch = var.is_public
  vpc_id = var.vpc_id
  tags = merge(var.tags, {Name = var.name})
} 

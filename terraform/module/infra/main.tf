resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
}

resource "aws_subnet" "fargate_subnet" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.subnet_cidr_block
    availability_zone       = var.availability_zone
    map_public_ip_on_launch = var.map_public_ip_on_launch
}

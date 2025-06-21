# AWS VPC
resource "aws_vpc" "this" {
    cidr_block              = var.cidr_block
    enable_dns_hostnames    = true
    tags = merge (
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${var.Project}-${var.Environment}"
        }
    )
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
    vpc_id      = aws_vpc.this.id
    tags   = merge(
        var.igw_tags,
        local.common_tags,
        {
            Name = "${var.Project}-${var.Environment}"
        }
    )

}

# Public Subnets in us-east-1a and 1b
resource "aws_subnet" "public" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.public_subnet_cidrs[count.index]
    availability_zone       = local.az_names[count.index]
    map_public_ip_on_lunch  = true
    tags    = merge(
        var.public_subnet_tags,
        local.common_tags,
        {
            Name = "${var.Project}-${var.Environment}-public-${local.az_names[count.index]}"
        }
    )

}

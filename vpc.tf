# AWS VPC
resource "aws_vpc" "this" {
    cidr_block              = var.cidr_block
    enable_dns_hostnames    = true
    tags = merge (
        var.vpc_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}"
            Name = local.Name
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
            # Name = "${var.Project}-${var.Environment}"
            Name = local.Name
        }
    )

}

# Public Subnets in us-east-1a and 1b
resource "aws_subnet" "public" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.public_subnet_cidrs[count.index]
    availability_zone       = local.az_names[count.index]
    map_public_ip_on_launch = true
    tags    = merge(
        var.public_subnet_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}-public-${local.az_names[count.index]}"
            Name = "${local.Name}-public-${local.az_names[count.index]}"
        }
    )
}

# private Subnets in us-east-1a and 1b
resource "aws_subnet" "private" {
    count                   = length(var.private_subnet_cidrs)
    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.private_subnet_cidrs[count.index]
    availability_zone       = local.az_names[count.index]
    tags    = merge(
        var.private_subnet_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}-private-${local.az_names[count.index]}"
            Name = "${local.Name}-private-${local.az_names[count.index]}"
        }
    )

}

# database Subnets in us-east-1a and 1b
resource "aws_subnet" "database" {
    count                   = length(var.database_subnet_cidrs)
    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.database_subnet_cidrs[count.index]
    availability_zone       = local.az_names[count.index]
    tags    = merge(
        var.database_subnet_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}-database-${local.az_names[count.index]}"
            Name = "${local.Name}-database-${local.az_names[count.index]}"
        }
    )

}

# Public route table
resource "aws_route_table" "public" {
    vpc_id      = aws_vpc.this.id
    tags = merge(
        var.public_route_table_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}-public"
            Name = "${local.Name}-public"
            
        }
    )
}

# private route table
resource "aws_route_table" "private" {
    vpc_id      = aws_vpc.this.id
    tags = merge(
        var.private_route_table_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}-private"
            Name = "${local.Name}-private"
        }
    )
}

# database route table
resource "aws_route_table" "database" {
    vpc_id      = aws_vpc.this.id
    tags = merge(
        var.database_route_table_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}-database"
            Name = "${local.Name}-database"
        }
    )
}
# Public subnet associations to Public route table
resource "aws_route_table_association" "public" {
    count           = length(var.public_subnet_cidrs)
    subnet_id       = aws_subnet.public[count.index].id
    route_table_id  = aws_route_table.public.id
} 

# Private subnet associations to Private route table
resource "aws_route_table_association" "private" {
    count           = length(var.private_subnet_cidrs)
    subnet_id       = aws_subnet.private[count.index].id
    route_table_id  = aws_route_table.private.id
}

# database subnet associations to database route table
resource "aws_route_table_association" "database" {
    count           = length(var.database_subnet_cidrs)
    subnet_id       = aws_subnet.database[count.index].id
    route_table_id  = aws_route_table.database.id
}

# Elastic IP 
resource "aws_eip" "nat" {
    domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
    allocation_id   = aws_eip.nat.id
    subnet_id       = aws_subnet.public[0].id
    tags = merge(
        var.nat_gateway_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}"
            Name = local.Name
        }
    )
}

# adding IGW to Public Routes 
resource "aws_route" "public" {
    route_table_id          = aws_route_table.public.id
    destination_cidr_block  = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.this.id
}

# adding NAt Gateway to Private Routes 
resource "aws_route" "private" {
    route_table_id          = aws_route_table.private.id
    destination_cidr_block  = "0.0.0.0/0"
    nat_gateway_id          = aws_nat_gateway.main.id
}

# adding NAt Gateway to database Routes 
resource "aws_route" "database" {
    route_table_id          = aws_route_table.database.id
    destination_cidr_block  = "0.0.0.0/0"
    nat_gateway_id          = aws_nat_gateway.main.id
}


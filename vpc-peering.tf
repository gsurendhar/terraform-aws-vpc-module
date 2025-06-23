# VPC Peering Connection Establishment
resource "aws_vpc_peering_connection" "default" {
    count           = var.is_peering_required ? 1 : 0
    peer_vpc_id     = data.aws_vpc.default.id
    vpc_id          = aws_vpc.this.id
    auto_accept     = true
    accepter   { allow_remote_vpc_dns_resolution = true }
    requester  { allow_remote_vpc_dns_resolution = true }
    tags = merge(
        var.peering_tags,
        local.common_tags,
        {
            # Name = "${var.Project}-${var.Environment}-default"
            Name = "${local.Name}-default"
        }
    )
}

# adding routes of peering in public route table
resource "aws_route" "public_peering" {
    count                           = var.is_peering_required ? 1 : 0
    route_table_id                  = aws_route_table.public.id
    destination_cidr_block          = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id       = aws_vpc_peering_connection.default[count.index].id
}

# adding routes of peering in private route table
resource "aws_route" "private_peering" {
    count                           = var.is_peering_required ? 1 : 0
    route_table_id                  = aws_route_table.private.id
    destination_cidr_block          = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id       = aws_vpc_peering_connection.default[count.index].id
}

# adding routes of peering in databse route table
resource "aws_route" "database-peering" {
    count                           = var.is_peering_required ? 1 : 0
    route_table_id                  = aws_route_table.database.id
    destination_cidr_block          = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id       = aws_vpc_peering_connection.default[count.index].id
}

# adding routes of peering in default route table
resource "aws_route" "default_peering" {
    count                           = var.is_peering_required ? 1 : 0
    route_table_id                  = data.aws_route_table.main.id
    destination_cidr_block          = aws_vpc.this.cidr_block
    vpc_peering_connection_id       = aws_vpc_peering_connection.default[count.index].id
}
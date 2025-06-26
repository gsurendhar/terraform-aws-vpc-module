variable "project" {
  type        = string
  description = "project name"
}

variable "environment" {
  type        = string
  description = "which environment project is running"
}

variable  "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "description"
}

variable "vpc_tags" {
  type        = map
  default     = {}
  description = "vpc tags if want specify"
}

variable "igw_tags" {
  type        = map
  default     = {}
  description = "internet gateway tags"
}
 
variable "public_subnet_cidrs" {
   type        = list
   description = "cidr rang of public subnets can be provided here in list"
 }
 
variable "public_subnet_tags" {
   type        = map
   default     = {}
   description = "Public subnet tags"
 }
 
variable "private_subnet_cidrs" {
   type        = list
   description = "cidr rang of public subnets can be provided here in list"
 }
 
variable "private_subnet_tags" {
   type        = map
   default     = {}
   description = "private subnet tags"
 }
 
variable "database_subnet_cidrs" {
   type        = list
   description = "cidr rang of public subnets can be provided here in list"
 }
 
variable "database_subnet_tags" {
   type        = map
   default     = {}
   description = "database subnet tags"
 }

variable "public_route_table_tags" {
   type        = map
   default     = {}
}

variable "private_route_table_tags" {
   type        = map
   default     = {}
}

variable "database_route_table_tags" {
   type        = map
   default     = {}
}

variable "eip_tags" {
    type = map(string)
    default = {}
}

variable "nat_gateway_tags" {
   type        = map
   default     = {}
}

variable "is_peering_required" {
   type        = string
   default     = false
}

variable "peering_tags" {
   type        = map
   default     = {}
}
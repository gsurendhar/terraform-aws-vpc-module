variable Project {
  type        = string
  description = "project name"
}

variable Environment {
  type        = string
  description = "which environment project is running"
}

variable  "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "description"
}

variable vpc_tags {
  type        = map
  default     = {}
  description = "vpc tags if want specify"
}

variable igw_tags {
  type        = map
  default     = {}
  description = "internet gateway tags"
}
 
 variable public_subnet_cidrs {
   type        = list
   description = "cidr rang of public subnets can be provided here in list"
 }
 
 variable public_subnet_tags {
   type        = map
   default     = {}
   description = "Public subnet tags"
 }
 


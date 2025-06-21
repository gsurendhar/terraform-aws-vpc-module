locals {   
    common_tags = {
        Project      = var.Project
        Environment  = var.Environment
        Terraform    = true
    }

    az_names    = slice(data.aws_availability_zones.available.names, 0, 2)
}



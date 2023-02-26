// This variable is to set the
// AWS custom VPC and everything will be 
// create in

// Variable to set the VPC 
variable "vpc_name" {
  description = "vpc for dev"
  type        = string
}

//  Variable to set the CIDR block
variable "cidr_vpc" {
  description = "CIDR for dev VPC"
  type        = string
}
// Variable to set the subnets (private and public)
variable "public_subnet" {
  description = "subnet for dev VPC"
  type        = list(any)
}

variable "private_subnet" {
  description = "subnet for dev VPC"
  type        = list(any)
}

variable "azs" {
  description = "azs for dev environment"
  type        = list(any)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "public_subnet_name" {
  description = "subnet name for dev"
  type        = list(any)
}

variable "private_subnet_name" {
  description = "subnet name for dev"
  type        = list(any)
}

variable "internet_access_name" {
  description = "internet gateway name"
  type        = string
}

variable "public_sg" {
  description = "security group for internet access"
  type        = string
}

variable "lb_sg" {
  description = "security group for load balancer"
  type        = string
}


variable "ingress_ssh_ports" {
  description = "ingress for ssh connection"
  type        = list(any)
}

variable "ingress_lb_ports" {
  description = "ingress for lb sg"
  type        = list(any)
}

variable "ingress_rds_ports" {
  description = "ingress for rds sg"
  type        = list(any)
  default     = [3306]
}

variable "key_name" {
  description = "Key name for ssh connection"
  type        = string
  default     = "cz75ww"
}

// This variable contains the config for RDS instances
variable "rds_settings" {
  description = "RDS conf settings"
  type        = map(any)
  default = {
    "database" = {
      identifier          = "fpsouza-rds-dev"
      allocated_storage   = 10
      engine              = "mysql"
      engine_version      = "8.0.27"
      instance_class      = "db.t2.micro"
      db_name             = "fpsouza-dev-db"
      username            = "admin"
      password            = "Just4now"
      skip_final_snapshot = true
    }
  }
}

variable "health_check" {
  type = map(any)
  default = {
    inputs = {
      timeout             = "10"
      interval            = "20"
      path                = "/"
      port                = "80"
      unhealthy_threshold = "2"
      healthy_threshold   = "3"
    }
  }
}
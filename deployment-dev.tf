module "dev-project" {
  source               = "./modules/dev"
  vpc_name             = "fpsouza-vpc-dev"
  cidr_vpc             = "10.0.0.0/16"
  public_subnet        = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet       = ["10.0.101.0/24", "10.0.102.0/24"]
  public_subnet_name   = ["public-subnet-1", "public-subnet-2", ]
  private_subnet_name  = ["private-subnet-1", "private-subnet-2", ]
  internet_access_name = "fpsouza-igw"
  public_sg            = "fpsouza-public-sg"
  lb_sg                = "fpsouza-lb-sg"
  ingress_ssh_ports    = [22]
  ingress_lb_ports     = [80, 8080, 443, 22]
}
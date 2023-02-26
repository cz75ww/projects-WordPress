# Build a WordPress Website on AWS using terraform and Ansible
## Requirements
* Terraform v1 or latest

## Introduction
In this project, we will deploy and host WordPress using terraform.
I'll  implement an architecture to host WordPress for a dev workload with minimal management responsibilities required. 

#### To deploy the AWS resources,terraform will create the following resources:
* VPC (Virtual Private Cloud)
* Public and Private subnets
* Route tables
* Internet Gatway
* Route Table
* Public, loadbalancer and  Security Groups (Firewall rules for ssh,icmp, https and http protocols)
** Public security group for ssh purpose
** load balancer security group for application layer (80, 8080, 443)
* Load balancer
* aws_launch_template
* Auto Scaling Group

### As a good practice, keep your terraform.tfstate file in a remote backend - [TerraformBackend](https://www.terraform.io/language/settings/backends)

#### Deploy steps
```
terraform init                      => "To initializer the backup and download the provider plugins"
terraform validate                  => "To validate your code / configuration"
terraform fmt -recursise            => "To put in a canonical format and style"
terraform plan                      => "To see build a execution plan from your code"
terraform apply --auto-approve      => "To apply / install your AWS resources via terraform"
terraform destroy --auto-approve    => "To destroy / uninstall your AWS resources via terraform"
```

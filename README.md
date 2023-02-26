# Build a WordPress Website on AWS using terraform and Ansible
## Requirements
* Terraform v1 or latest

## Introduction
In this project, we will deploy and host WordPress with terraform and Ansible.
I'll  implement an architecture to host WordPress for a production workload with minimal management responsibilities required. To accomplish this, I'm gonna to use AWS Elastic Beanstalk and Amazon Relational Database Service (RDS). Once I'll upload the WordPress files, Elastic Beanstalk automatically handles the deployment, from capacity provisioning, load balancing, auto-scaling to application health monitoring. Amazon RDS provides cost-efficient and resizable capacity, while managing time-consuming database administration tasks for you.

#### To deploy the AWS resources,terraform will create the following resources:
* VPC (Virtual Private Cloud)
* Public and Private subnets
* Route tables
* Internet Gatway
* Route Table
* Public, loadbalancer and RDS Security Groups (Firewall rules for ssh,icmp, https and http protocols)
** Public security group for ssh purpose
** load balancer security group for application layer (80, 8080, 443)
** RDS security group for database connection 3306
* Elastic Beanstalk environment
* Load balancer
* Auto Scaling Group
* RDS (Amazon Relational Database Service)

### As a good practice, keep your terraform.tfstate file in a backend - [TerraformBackend](https://www.terraform.io/language/settings/backends)

## Setup
#### To run this project, perform the command lines:
* In the terrform root folder change the deployment-dev.tf according your needs.
* PS: In the first time, you will have to perform the terraform apply twice because to create ASG, this is a requirement to already have the subnets set ups.
* Once you built the subnets successfully, uncomment the lines on data.tf and ec2-asg.tf files to create the ASG resource


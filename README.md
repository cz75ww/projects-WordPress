# Build a WordPress Website on AWS using terraform
## Requirements
* Terraform v1 or latest

## Introduction
In this project, we will deploy and host WordPress application using terraform.
I'll  implement an architecture to host WordPress for a dev workload with minimal management responsibilities required. 

#### To deploy the AWS resources,terraform will create the following items:
* VPC (Virtual Private Cloud)
* Public and Private subnets
* Route tables
* Internet Gateway
* Route Table
* Loadbalancer security group in order to set up firewall rules for icmp, https and http protocols
* Public Security group for ssh connection
* Load balancer
* aws_launch_template
* Auto Scaling Group

##### As a good practice, keep your terraform.tfstate file in a remote backend - [TerraformBackend](https://www.terraform.io/language/settings/backends)

#### Deploy steps
Under envs folders you can create a subfolder for each environment fill a tf main file
For demo purpose I have built a dev folder to deploy a DEV environment
```
# Execute the cmds below into /envs/<env>/ e.g: /envs/dev/
terraform init                      # Initializer the backend and download the provider plugins
terraform validate                  # Validate your code / configuration
terraform fmt -recursise            # To put in a canonical format and style
terraform plan                      # See an execution plan from your code
terraform apply --auto-approve      # Apply / install your AWS resources via terraform
terraform destroy --auto-approve    # Destroy / uninstall your AWS resources via terraform
```

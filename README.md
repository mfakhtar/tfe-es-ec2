# Terraform Enterprise Guide

## Why we have this repo
??

## Diagram for the Infrastucture Created
![Screenshot](diagram/aws_infrastructure.png)

## Descrition
This repository contains Terraform code to deploy the following infrastructure on AWS:

- VPC
- Subnet
- Internet Gateway
- Security Groups
- EC2 instance
- S3 bucket
- EC2 instance role to connect to S3
- AWS DB Subnet Group
- RDS Database

## Prerequisites

Before deploying this infrastructure, you will need:

- An AWS account with permissions to create the above resources
- Authentication/Access and Secret Access Key to AWS Account
- Terraform CLI installed on your local machine

## Usage

To deploy the infrastructure, follow these steps:

- Clone this repository to your local machine.
```
how
```

- Run `terraform init`
```
how
```

- Run `terraform plan`
```
how
```

- Run `terraform apply`
```
how
```



## Connect to the instance

- create ssh key
```
terraform output private_key_pem | grep -v EOT > ~/.ssh/terraform.pem
chmod 0600 ~/.ssh/terraform.pem
```

- grab command to connect to instance
```
terraform output ssh_public_ip
```

- connect to instance
```
how
```

## Cleaning up
To delete the infrastructure
- run `terraform destroy`
```
how
```

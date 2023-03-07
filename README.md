# Terraform Infrastructure Code

This repository contains Terraform code to deploy the following infrastructure on AWS:

- 1 VPC
- 2 Subnets
- 1 Internet Gateway
- 2 Security Groups
- 1 EC2 instance
- 1 S3 bucket
- EC2 instance role to connect to S3 and RDS
- AWS DB Subnet Group

## Prerequisites

Before deploying this infrastructure, you will need:

- An AWS account with permissions to create the above resources
- AWS CLI installed and configured on your local machine
- Terraform CLI installed on your local machine

## Usage

To deploy the infrastructure, follow these steps:

1. Clone this repository to your local machine.

2. Navigate to the `terraform` directory.

3. Create a `terraform.tfvars` file with the following contents:

instance_type = "t2.medium"
vpc_cidr = "10.0.0.0/24"
subnet_cidr = "10.0.0.0/28"
db_subnet_cidr = "10.0.0.16/28"
bucket_name = "s3-bucket-tfe"
db_user = "admin1"
db_pass = "Password"
db_instance_type = "db.t2.micro"
tfe-pwd = "fawaz123"
tfe_release_sequence = "652"

4. Run `terraform init` to initialize the Terraform configuration.
5. Run `terraform plan` to generate an execution plan.
6. If the execution plan looks good, run `terraform apply` to apply the changes to your AWS account.
7. Once the infrastructure is deployed, you should see a new VPC, subnets, internet gateway, security groups, EC2 instance, S3 bucket, EC2 instance role, and DB subnet group in your AWS account.

## Cleaning up
To delete the infrastructure, run `terraform destroy` from the `terraform` directory.

## License
This code is licensed under the MIT License. See the `LICENSE` file for details.

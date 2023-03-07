
#Add VPC
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "fawaz-tfe-es-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    "name" = "fawaz-tfe-es-vpc"
  }
}

#AWS Subnet for TFE
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "fawaz-tfe-es-sub" {
  vpc_id            = aws_vpc.fawaz-tfe-es-vpc.id
  cidr_block        = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
  tags = {
    "name" = "fawaz-tfe-es-pub-sub"
  }
}

#AWS Subnet for db
resource "aws_subnet" "fawaz-tfe-es-sub-db" {
  vpc_id            = aws_vpc.fawaz-tfe-es-vpc.id
  cidr_block        = var.db_subnet_cidr
  tags = {
    "name" = "fawaz-tfe-es-pub-sub"
  }
}

#AWS IGW
resource "aws_internet_gateway" "fawaz-tfe-es-igw" {
  vpc_id = aws_vpc.fawaz-tfe-es-vpc.id

  tags = {
    Name = "fawaz-tfe-es-igw"
  }
}

#AWS RT
resource "aws_route_table" "fawaz-tfe-es-pub-rt" {
  vpc_id = aws_vpc.fawaz-tfe-es-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fawaz-tfe-es-igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.fawaz-tfe-es-igw.id
  }

  tags = {
    Name = "fawaz-tfe-es-pub-rt"
  }
}


resource "aws_route_table" "fawaz-tfe-es-pri-rt" {
  vpc_id = aws_vpc.fawaz-tfe-es-vpc.id

  tags = {
    Name = "fawaz-tfe-es-pri-rt"
  }
}

resource "aws_route_table_association" "fawaz-tfe-es-pub-rt-asc" {
  subnet_id      = aws_subnet.fawaz-tfe-es-sub.id
  route_table_id = aws_route_table.fawaz-tfe-es-pub-rt.id
}
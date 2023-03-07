#Add Provider Block
provider "aws" {
  region = var.region
}



#Add EC2 Block
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "fawaz-tfe-es-ec2" {
  availability_zone           = "ap-south-1a"
  ami                         = "ami-0f8ca728008ff5af4"
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.fawaz-tfe-es-sg.id]
  subnet_id                   = aws_subnet.fawaz-tfe-es-sub.id
  associate_public_ip_address = true
  key_name                    = "fawaz-tfe-guide"
  root_block_device {
    volume_size = "50"
  }
  user_data = templatefile("${path.module}/user-data.sh", {
    bucket_name          = var.bucket_name
    region               = var.region
    tfe-pwd              = var.tfe-pwd
    tfe_release_sequence = var.tfe_release_sequence
    db_name              = aws_db_instance.default.db_name
    db_address           = aws_db_instance.default.address
    db_password          = var.db_pass
  })


  iam_instance_profile = aws_iam_instance_profile.fawaz-tfe-es-inst.id

}
/*
resource "aws_eip" "fawaz-tfe-eip" {
  instance = aws_instance.fawaz-tfe-es-ec2.id
}

data "aws_route53_zone" "selected" {
  name         = "tf-support.hashicorpdemo.com."
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "fawaz-tfe"
  type    = "A"
  ttl     = 300
  records = [aws_eip.fawaz-tfe-eip.public_ip]
}
*/
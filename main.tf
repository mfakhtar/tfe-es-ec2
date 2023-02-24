#Add Provider Block
provider "aws" {
  region = var.region
}



#Add EC2 Block
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "fawaz-tfe-es-ec2" {
    ami = data.aws_ami.ubuntu.id 
    instance_type = var.instance_type
    security_groups = [ aws_security_group.fawaz-tfe-es-sg.id ]
    root_block_device {
    volume_size = "50"
    }
    user_data = templatefile("${path.module}/user-data.sh", {
        bucket_name = var.bucket_name
        hostname = var.hostname
        region = var.region
        tfe-pwd = var.tfe-pwd
        tfe_release_sequence = var.tfe_release_sequence
        hostname = var.hostname
        db_name = aws_db_instance.default.db_name
        db_address = aws_db_instance.default.address
        db_password = var.db_pass
        })


    iam_instance_profile = aws_iam_instance_profile.fawaz-tfe-es-inst.id

}
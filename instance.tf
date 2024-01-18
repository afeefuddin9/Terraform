#Selecting the AMI for the Instance
data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}


# Defining Instance Confuguring
resource "aws_instance" "terraform-auto-instance" {
  ami                  = data.aws_ami.amazon-2.id
  instance_type        = var.instance_type
  security_groups      = ["sg-01**********id"] #Replace with you SG ID
  subnet_id            = "subnet-01**********id" #Replace with you Subnet ID
  key_name             = "staging"
  iam_instance_profile = "aws-a0001-iam-rol-name" #Mention your IAM NAME

  tags = {
    Name = "Terraform-instance-box-1" #Instance Name
  }
  #user data running script form local to ec2 box
  user_data = file("${path.module}/script.sh")

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("staging.pem")
    host        = self.private_ip
  }

  provisioner "file" {
    source      = "./deploy.yml"
    destination = "/home/ec2-user/deploy.yml"
  }


}



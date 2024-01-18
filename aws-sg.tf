
# #Confuguring Security Group
# resource "aws_security_group" "instance_security_group" {
#   name        = "instance-security-group"
#   description = "Security group for the EC2 instance"
#   vpc_id      = "vpc-01*********id" #Replace this with your VPC ID


#   dynamic "ingress" {
#     for_each = var.ports
#     iterator = port
#     content {
#       description = "TLS from VPC"
#       from_port   = port.value
#       to_port     = port.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"] # Update with appropriate source IP ranges

#     }

#   }

#   # Add any additional ingress rules you require
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
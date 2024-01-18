# Post instance launch output
output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.terraform-auto-instance.private_ip
}

output "instance_id" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.terraform-auto-instance.id
}


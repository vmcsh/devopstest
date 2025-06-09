output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.this.arn
}

output "elastic_ip" {
  description = "Elastic IP address associated with the instance"
  value       = aws_eip.this.public_ip
}

output "elastic_ip_id" {
  description = "The ID of the Elastic IP resource"
  value       = aws_eip.this.id
}

output "security_group_id" {
  description = "The ID of the security group attached to the EC2 instance"
  value       = aws_security_group.allow_ssh.id
}

output "availability_zone" {
  description = "The availability zone where the EC2 instance is launched"
  value       = aws_instance.this.availability_zone
}

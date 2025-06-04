# Bastion Host Module - Outputs

output "bastion_id" {
  description = "ID of the bastion host EC2 instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = var.create_eip ? aws_eip.bastion_eip[0].public_ip : aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  value       = aws_instance.bastion.private_ip
}

output "bastion_security_group_id" {
  description = "ID of the security group attached to the bastion host"
  value       = aws_security_group.bastion_sg.id
}

output "bastion_ami_id" {
  description = "ID of the AMI used for the bastion host"
  value       = data.aws_ami.amazon_linux_2023.id
}

output "bastion_ami_name" {
  description = "Name of the AMI used for the bastion host"
  value       = data.aws_ami.amazon_linux_2023.name
}

output "ssh_command" {
  description = "SSH command to connect to the bastion host"
  value       = "ssh -i ${var.private_key_path} ec2-user@${var.create_eip ? aws_eip.bastion_eip[0].public_ip : aws_instance.bastion.public_ip}"
}
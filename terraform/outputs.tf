output "public_ec2_public_ip" {
  description = "IP cong cong cua public EC2 - dung de SSH"
  value       = module.public_ec2.public_ip
}

output "private_ec2_private_ip" {
  description = "IP noi bo cua private EC2 - SSH tu public EC2"
  value       = module.private_ec2.private_ip
}
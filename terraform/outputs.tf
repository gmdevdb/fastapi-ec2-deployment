output "ec2_public_ip" {
  value = aws_instance.fastapi_ec2.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.fastapi_ec2.public_dns
}


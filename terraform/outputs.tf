output "vpn_instance_id" { value = aws_instance.vpn_gateway.id }
output "application_instance_id" { value = aws_instance.application.id }
output "vpn_public_ip" { value = aws_instance.vpn_gateway.public_ip }
output "application_private_ip" { value = aws_instance.application.private_ip }

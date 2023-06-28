output "Pi-Hole_URL" {
  value = "http://${aws_instance.ec2_instance.public_ip}/admin/"
}
output "AMI-ID" {
  value = aws_instance.ec2_instance.ami
}
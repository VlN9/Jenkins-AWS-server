output "jen_server_pub_ip" {
  value = aws_instance.jen_server.public_ip
}

output "jen_server_prvt_ip" {
  value = aws_instance.jen_server.private_ip
}
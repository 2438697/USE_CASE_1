resource "aws_instance" "web" {
  ami           = "ami-0a627a85fdcfabbaa" 
  instance_type = "t3.micro"
  key_name      = aws_key_pair.value_key.key_name
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "Terraform-Web-Server"
  }
}
resource "tls_private_key" "value1_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "value_key" {
  key_name   = "key"
  public_key = tls_private_key.value1_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.value1_key.private_key_pem
  filename = "value-key.pem"
}



output "public_ip" {
  value = aws_instance.web.public_ip
}
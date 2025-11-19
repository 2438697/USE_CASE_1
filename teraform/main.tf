resource "aws_instance" "web" { # Define an EC2 instance resource named "web"
  ami           = "ami-0a627a85fdcfabbaa"  # The Amazon Machine Image (AMI) ID to use for the instance
  instance_type = "t3.micro"  # The instance type (size) for the EC2 instance
  key_name      = aws_key_pair.value_key.key_name  # Reference to the EC2 key pair name to allow SSH access
  security_groups = [aws_security_group.web_sg.name]  # Attach the security group(s) by name

  tags = { # Tags block to apply metadata to the instance
    Name = "Terraform-Web-Server"  # Tag 'Name' with a human-readable identifier
  }
} # end of aws_instance "web" resource

output "public_ip" { # Define an output to expose the EC2 instance public IP after apply
  value = aws_instance.web.public_ip  # Output the public IP attribute of the aws_instance.web resource
} # end of output "public_ip"

resource "tls_private_key" "value1_key" { # Generate a TLS private key locally
  algorithm = "RSA"  # Use the RSA algorithm for the generated key
  rsa_bits  = 4096  # Key size in bits (4096 for strong security)
} # end of tls_private_key "value1_key"

resource "aws_key_pair" "value_key" { # Create an AWS key pair resource using the generated public key
  key_name   = "key"  # The name to give the key pair in AWS
  public_key = tls_private_key.value1_key.public_key_openssh  # Use the generated public key in OpenSSH format
} # end of aws_key_pair "value_key"

resource "local_file" "private_key" { # Write the generated private key to a local file
  content  = tls_private_key.value1_key.private_key_pem  # The private key content in PEM format
  filename = "value-key.pem"  # The filename where the private key will be saved
} # end of local_file "private_key"

 # Spacer comment: separation between resources (no functional effect)


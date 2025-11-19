resource "aws_security_group" "web_sg" { # Define a security group for the web server
  name        = "web_sg" # Name of the security group
  description = "Allow HTTP and SSH" # Description of the security group

  ingress { # Ingress rule to allow SSH access
    from_port   = 22 # The starting port for the SSH access range
    to_port     = 22 # The ending port for the SSH access range
    protocol    = "tcp" # The protocol to allow (TCP for SSH)
    cidr_blocks = ["0.0.0.0/0"] # Allow access from any IP address
  }

  ingress { # Ingress rule to allow HTTP access
    from_port   = 80 # The starting port for the HTTP access range
    to_port     = 80 # The ending port for the HTTP access range
    protocol    = "tcp" # The protocol to allow (TCP for HTTP)
    cidr_blocks = ["0.0.0.0/0"] # Allow access from any IP address
  }

  egress { # Egress rule to allow all outbound traffic
    from_port   = 0 # The starting port for the outbound traffic range
    to_port     = 0 # The ending port for the outbound traffic range
    protocol    = "-1" # The protocol to allow (all protocols)
    cidr_blocks = ["0.0.0.0/0"] # Allow access to any IP address
  }
}
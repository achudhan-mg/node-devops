resource "aws_instance" "web" {
  ami           = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  associate_public_ip_address = true
  key_name = "Every"
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              #sudo apt install apache2 -y
              #sudo systemctl start apache2
              #sudo bash -c 'echo your very first web server > /var/www/html/index.html'
              sudo apt update
              sudo apt install -y nginx
              EOF
  tags = {
    Name = "Terraform"
  }

  root_block_device {
    volume_size           = "25"
    volume_type           = "gp2"
    encrypted             = false
    delete_on_termination = true
  }
}

resource "aws_security_group" "web" {
  name = "web-SG"
  description = "Allow Web inbound traffic"
  vpc_id = "vpc-05ed220fe17756a7d"

  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SG-EC2"
  }
}

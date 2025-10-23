provider "aws" {
  region = "eu-north-1"
  profile = "default"
}

resource "aws_security_group" "kt_app_sg" {
  name        = "kt_app_sg"
  description = "Allow SSH + HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Port Flask (or Gunicorn)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_key_pair" "kt_app_key" {
  key_name   = "kt_app_key"
  public_key = file("~/.ssh/id_ed25519.pub")
}
resource "aws_instance" "kt_app" {
  ami           = "ami-0a716d3f3b16d290c"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.kt_app_key.key_name

  security_groups = [aws_security_group.kt_app_sg.name]

  tags = {
    Name = "KT-App-Instance"
  }
}
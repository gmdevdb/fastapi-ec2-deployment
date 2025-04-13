resource "aws_security_group" "fastapi_sg" {
  name        = "fastapi-sg"
  description = "Allow SSH and FastAPI ports"
  vpc_id      = data.aws_vpc.default.id

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["162.196.194.119/32"]  # Replace with your actual IP
  }

  # HTTP (port 80) — optional if running Uvicorn directly on 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # FastAPI default port (8000)
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fastapi-sg"
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "fastapi_ec2" {
  ami                         = "ami-0c02fb55956c7d316" # Ubuntu 20.04 (us-east-1)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.fastapi_sg.id]

  tags = {
    Name = "FastAPI-EC2"
  }

  associate_public_ip_address = true
}

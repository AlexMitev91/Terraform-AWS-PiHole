provider "aws" {
  region  = "eu-central-1"
  profile = "terraform"
}

resource "aws_vpc" "pi-hole-vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "PI-HOLE-VPC"
  }
}

resource "aws_internet_gateway" "pi-hole-igw" {
  vpc_id = aws_vpc.pi-hole-vpc.id
  tags = {
    Name = "PI-HOLE-IGW"
  }
}

resource "aws_route_table" "pi-hole-prt" {
  vpc_id = aws_vpc.pi-hole-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pi-hole-igw.id
  }
  tags = {
    Name = "PI-HOLE-PRT"
  }
}

resource "aws_subnet" "pi-hole-snet" {
  vpc_id                  = aws_vpc.pi-hole-vpc.id
  cidr_block              = "10.10.10.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "PI-HOLE-NET"
  }
}

resource "aws_route_table_association" "pi-hole-prt-assoc" {
  subnet_id      = aws_subnet.pi-hole-snet.id
  route_table_id = aws_route_table.pi-hole-prt.id
}

resource "aws_security_group" "pi-hole-pub-sg" {
  name        = "pi-hole-pub-sg"
  description = "Pi-Hole Public SG"
  vpc_id      = aws_vpc.pi-hole-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["77.70.30.156/32"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["77.70.30.156/32"]
  }
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["77.70.30.156/32"]
  }
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["77.70.30.156/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# launch the ec2 instance and install website
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0ab1a82de7ca5889c"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pi-hole-snet.id
  vpc_security_group_ids = [aws_security_group.pi-hole-pub-sg.id]
  key_name               = "terraform"
  user_data              = file("bootstrap.sh")

  tags = {
    Name = "pi-hole EC2 instance"
  }
}

output "website_url" {
  value = aws_instance.ec2_instance.public_ip
}
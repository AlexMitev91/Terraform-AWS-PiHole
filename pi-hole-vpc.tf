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
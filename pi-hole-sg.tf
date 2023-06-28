resource "aws_security_group" "pi-hole-pub-sg" {
  name        = "pi-hole-pub-sg"
  description = "Pi-Hole Public SG"
  vpc_id      = aws_vpc.pi-hole-vpc.id

  dynamic "ingress" {
    for_each = var.pi-ports-tcp
    iterator = port
    content {
    from_port   = port.value
    to_port     = port.value
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_allow]
    }
  }
  ingress {
    from_port   = var.pi-ports-tcp[2]
    to_port     = var.pi-ports-tcp[2]
    protocol    = "udp"
    cidr_blocks = [var.cidr_block_allow]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block_allow]
  }
}
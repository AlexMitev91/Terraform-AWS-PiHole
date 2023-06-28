provider "aws" {
  region  = "eu-central-1"
  profile = "terraform"
}

resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pi-hole-snet.id
  vpc_security_group_ids = [aws_security_group.pi-hole-pub-sg.id]
  key_name               = "terraform"
  user_data              = file("./scripts/bootstrap.sh")

  tags = {
    Name = "pi-hole EC2 instance"
  }
}


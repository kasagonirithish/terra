resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "mykrvpc"
  }
}

resource "aws_subnet" "public" {
  availability_zone       = var.availability-zone
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet-cidr
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Public-Subnet"
  }
}


resource "aws_subnet" "private" {
  availability_zone       = var.availability-zone
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet-cidr-2
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Private-Subnet"
  }
}


resource "aws_route_table" "Rt-Pub" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myrt-pub"
  }
}


resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "my-internet"
  }
}

resource "aws_route_table" "Rt-Pri" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myrt-pri"
  }
}


resource "aws_route" "internet-attaching" {
  route_table_id         = aws_route_table.Rt-Pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myigw.id
}


resource "aws_route_table_association" "public_sub_ass" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.Rt-Pub.id
}

resource "aws_route_table_association" "private_sub_ass" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.Rt-Pri.id
}



resource "aws_security_group" "allow_tls" {
  name   = "allow_tls"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "rithish-Public-server" {
  ami           = var.ami-id
  instance_type = var.instance-type
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [
    aws_security_group.allow_tls.id
  ]
  associate_public_ip_address = true

  tags = {
    Name = "Public-Server"
  }
}
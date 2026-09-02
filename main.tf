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
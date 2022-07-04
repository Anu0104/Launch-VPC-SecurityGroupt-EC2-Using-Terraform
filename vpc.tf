resource "aws_vpc" "TF_VPC" {
  cidr_block       = var.cidr_value
  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_internet_gateway" "tf_ig" {
  vpc_id = aws_vpc.TF_VPC.id
  tags = {
    Name = "tf_ig"
  }
}

resource "aws_subnet" "tf-subnet" {
  count = length(var.subnet_value)
  vpc_id     = aws_vpc.TF_VPC.id
  cidr_block = element(var.subnet_value , count.index)
  availability_zone = element(var.az_values , count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "tf_subnet_${count.index+1}"
  }
}

resource "aws_route_table" "tf_route" {
  vpc_id = aws_vpc.TF_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_ig.id
  }
  tags = {
    Name = "tf_route"
  }
}

resource "aws_route_table_association" "connect_route_subnet" {
  subnet_id      = aws_subnet.tf-subnet[0].id 
  route_table_id = aws_route_table.tf_route.id
}
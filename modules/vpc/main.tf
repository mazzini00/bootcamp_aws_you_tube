resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.application_name}-public-vpc"
  } 
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.0.0.0/25" 
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.application_name}-public-subnet"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.0.0.128/25" 
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.application_name}-public-subnet"
  }
}

resource "aws_internet_gateway" "this" {
   vpc_id = aws_vpc.this.id
   
   tags = {
     Name = "${var.application_name}-Internet-Gateway"
   }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  
  tags = {
     Name = "${var.application_name}-Route-Table"
   }
}

resource "aws_route" "this" {
  route_table_id = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
  
}

resource "aws_route_table_association" "table_a" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.this.id
  
}

resource "aws_route_table_association" "table_b" {
  subnet_id = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.this.id
  
}


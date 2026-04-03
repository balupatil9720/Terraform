# Create Vpc
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="my-vpc"
  }
}

# Create Private Subnet
resource "aws_subnet" "private-subnet" {
cidr_block = "10.0.1.0/24"
vpc_id = aws_vpc.my-vpc.id
tags = {
  Name ="Private-Subnet"
}
}

# Create Public Subnet
resource "aws_subnet" "public-subnet" {
cidr_block = "10.0.2.0/24"
vpc_id = aws_vpc.my-vpc.id
tags = {
  Name ="Public-Subnet"
}
}

# Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name="My-Internet-Gateway"
  }
}

# Create Route table

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route  {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.my-igw.id
  }
}

# route Association
resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.public-subnet.id
}
# Create Custom Vpc
resource "aws_vpc" "tf-Vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "tf-Vpc"
  }
}
# Create Internet gateway
resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-Vpc.id
  tags = {
    Name = "tf-igw"
  }
}

# Create Subnets
resource "aws_subnet" "tf-subnet-pub" {
  count                   = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.tf-Vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  tags = {
    Name                         = "tf-subnet-pub-${count.index}"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "shared"
  }
}
resource "aws_subnet" "tf-subnet-priv" {
  count                   = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.tf-Vpc.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 3)
  tags = {
    Name                         = "tf-subnet-priv-${count.index}"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "shared"
  }
}
# Create Route Table
resource "aws_route_table" "tf-pub-rt" {
  vpc_id = aws_vpc.tf-Vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }
  tags = {
    Name = "tf-pub-rt"
  }
}
resource "aws_route_table" "tf-priv-rt" {
  vpc_id = aws_vpc.tf-Vpc.id
  count  = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "172.30.0.0/16"
    #gateway_id = "local"
    gateway_id = aws_nat_gateway.tf-natgw.*.id[0]
  }
  tags = {
    Name = "tf-priv-rt"
  }
}

# Create Route Table Association
resource "aws_route_table_association" "tf-pub-rta" {
  count = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  #subnet_id = aws_subnet.tf-subnet-pub.id 
  subnet_id      = aws_subnet.tf-subnet-pub.*.id[count.index]
  route_table_id = aws_route_table.tf-pub-rt.id
}
resource "aws_route_table_association" "tf-priv-rta" {
  count = length(slice("${data.aws_availability_zones.azs.names}", 0, 2))
  #subnet_id = aws_subnet.tf-subnet-pub.id 
  subnet_id      = aws_subnet.tf-subnet-priv.*.id[count.index]
  route_table_id = aws_route_table.tf-priv-rt.*.id[count.index]

}

resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
    tags = {
        Name = var.rt_name
    }
}

# resource "aws_route" "route" {
#   route_table_id         = aws_route_table.rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id    = aws_internet_gateway.igw.id
# }

resource "aws_route_table_association" "rta_1" {
  subnet_id      = data.aws_subnet.subnet_1.id
  route_table_id = aws_route_table.rt.id
  depends_on     = [aws_route_table.rt]
}

resource "aws_route_table_association" "rta_2" {
  subnet_id      = data.aws_subnet.subnet_2.id
  route_table_id = aws_route_table.rt.id
  depends_on     = [aws_route_table.rt]
}
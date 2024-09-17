resource "aws_eip" "eip" {
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id      = data.aws_subnet.subnet.id
  connectivity_type = "public"
  tags = {
    Name = var.natgw_name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
    tags = {
        Name = var.rt_name
    }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = data.aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
  depends_on     = [aws_route_table.rt]
}
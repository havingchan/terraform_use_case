resource "aws_subnet" "subnet" {
    vpc_id     = data.aws_vpc.vpc.id
    availability_zone = var.az
    cidr_block = var.cidr_block
    tags = {
        Name = var.subnet_name
    }
}

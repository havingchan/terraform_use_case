provider "aws" {
    region = "us-west-2"
}

resource "aws_subnet" "main" {
    vpc_id     = data.aws_vpc.main.id
    cidr_block = "10.0.0.0/24"
}
provider "aws" {
    region = "us-west-2"  # Specify your desired region
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "main-vpc"
    }
}
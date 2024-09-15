data "aws_vpc" "main" {
    filter {
        name   = "tag:Name"
        values = ["main-vpc"]
    }
}
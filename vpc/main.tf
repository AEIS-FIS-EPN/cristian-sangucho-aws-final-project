resource "aws_vpc" "fis_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc AEIS instance" 
    description = ""
  }
}

output "fis_vpc_id" {
    value = aws_vpc.fis_vpc.id
}
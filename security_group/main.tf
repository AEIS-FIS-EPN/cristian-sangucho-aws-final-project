variable "fis_vpc_id" {
}



#Bloque
resource "aws_security_group" "web_server_sg" {
  vpc_id = var.fis_vpc_id
  #sub-bloque
  ingress {
    description = "Allow HTTP trafic from internet"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]       
  }

  ingress {
    description = "Allow HTTPS trafic from internet"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all trafic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  #bloque de propiedades
  tags = {
    Name = "aeis security group"
  }          
}


output "web_server_sg_id" {
    value = aws_security_group.web_server_sg.id
}
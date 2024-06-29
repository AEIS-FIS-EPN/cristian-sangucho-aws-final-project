variable "network_interface_id" {
}

variable "private_ips" {
}

#bloque de datos
data "aws_ami" "ubuntu_ami" {
  most_recent = "true"
  filter {
    name = "name"  #
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  #tipos de virtualizacion
  #hvm ---> aws
  #pv ---> azure
  filter {
    name   = "virtualization-type"
    values = ["hvm"]  #simula un servidor fisico
  }
  #https://documentation.ubuntu.com/aws/en/latest/aws-how-to/instances/find-ubuntu-images/
  #cada owner tiene su id
  owners = [ "099720109477" ]
}

resource "aws_instance" "ubuntu-aeis-instance" {
  ami = data.aws_ami.ubuntu_ami.id
  instance_type = "t2.micro" 
  network_interface {
    network_interface_id = var.network_interface_id
    device_index = 0                                      #determina el orden de interfaces de red
  }
  #inicia nginx en un proceso demon
  user_data = <<-EOF
              #!bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx        
              EOF
  #siempre metadata al final
  tags = {
    Name = "Ubuntu AEIS instance" 
    description = ""
  }
  
}

resource "aws_eip" "aeis_eip" {
  associate_with_private_ip = tolist(var.private_ips)[0]
  network_interface         = var.network_interface_id
  instance = aws_instance.ubuntu-aeis-instance.id
  tags = {
    Name = "aeis elastic ip"
  }
}

output "ubuntu_aeis_instance_id" {
    value = aws_instance.ubuntu-aeis-instance.id
}

output "public_aeis_ip" {
  value = aws_eip.aeis_eip.private_ip
}
output "aeis_ip" {
  value = aws_eip.aeis_eip.public_ip
}
variable "subnet_id" {
}

variable "web_server_sg_id" {
}


resource "aws_network_interface" "aeis_network_interface" {
  #interface punto en el que todos cosas interactuan (puertas de enlace) (punto de entrada
  #networkinterface puerto de interaccon entre dos nets)
  subnet_id = var.subnet_id
  #elasticIP asociar aun recurso, cambiar esa ip pero tambien fijarle
  #permite cambiarla a traves de una definicion
  #mantener la conectividad a servicios internos
  private_ips = ["10.0.1.26"]
  security_groups = [var.web_server_sg_id]
}


output "network_interface_id" {
    value = aws_network_interface.aeis_network_interface.id
}

output "private_ips" {
    value = aws_network_interface.aeis_network_interface.private_ips
}
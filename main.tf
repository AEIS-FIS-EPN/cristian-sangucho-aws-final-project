# Link auth
provider "aws" {
  shared_config_files      = ["C:/Users/intel/.aws/config"]      
  shared_credentials_files = ["C:/Users/intel/.aws/credentials"] 
}
###############################PONER TAGSSSSSSSSSSSSSSSSS
module "vpc" {
  source = "./vpc" 
}

module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.fis_vpc_id
}

module "security_groups" {
  source = "./security_group"
  fis_vpc_id = module.vpc.fis_vpc_id
}

module "network_interface" {
  source = "./network-interface"
  subnet_id = module.subnet.subnet_id
  web_server_sg_id = module.security_groups.web_server_sg_id

}

module "ec2_instances" {
    source = "./ec2_instances"
    network_interface_id = module.network_interface.network_interface_id
    private_ips = module.network_interface.private_ips
    depends_on = [ module.network_interface ]

}

module "ecr" {
  source = "./ecr"

  
}

output "public_ip" {
  value = module.ec2_instances.public_aeis_ip
  description = "value"
}
output "private_ip" {
  value = module.ec2_instances.aeis_ip
  
}
output "url_ecr_repository_aeis" {
  value = module.ecr.url_ecr_repository_aeis
}
#internet GW tiene limitantes por que ghay que especificarle por donde tiene que salir
#----------------------------------------------------------------
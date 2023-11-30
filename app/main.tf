provider "aws" {
  region = "eu-west-1"
}

module "network" {
  source = "./network"
  
}



module "ec2" {
 source = "./ec2"
 my_public_subnet = module.network.network_output
 
}


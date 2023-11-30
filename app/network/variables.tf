#variable "aws_region" {
  
 # type        = string
  #default     = "eu-west-1"
  
#}

variable "vpc-cidr" {
  
  type        = string
  default     = "10.0.0.0/16"
  
}

variable "subnet_public_cidr" {
  
  type        = string
  default     = "10.0.1.0/24"
  
}


variable "sg_ports" {
  type        = list(number)
  description = "list of ingress and egress ports"
  default     = [80, 443]
}


variable "type_instance" {
  
  type        = string
  default     = "t2.micro"
  
}

variable "ebs_size" {
  
  type        = number
  default     = "30"
  
}

variable "my_public_subnet" {
  
  type        = string
  default     = "default"
  
}


resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc-cidr
tags = {
   Name = "my_vpc"
  }
}


resource "aws_subnet" "my_public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnet_public_cidr
  #availability_zone = "eu-west-1a"
  tags = {
    Name = "tf-example-subnet-public"
  }
}


resource "aws_internet_gateway" "my_ig" {
   vpc_id = aws_vpc.my_vpc.id
   tags = {
     Name = "my_Gateway"
   }
}

resource "aws_route_table" "my_public_route_table" {
   vpc_id = aws_vpc.my_vpc.id
   
   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.my_ig.id
   }

   tags = {
     Name = "tf-public-routetable"
   }
}

resource "aws_route_table_association" "public_1_rt_a" {
 subnet_id = aws_subnet.my_public_subnet.id
 route_table_id = aws_route_table.my_public_route_table
}




#creation dune elastic ip
resource "aws_eip" "elastic" {
  instance = aws_instance.my_ec2.id  #machine EC2
  domain   = "vpc"
}


#creation d'un groupe de securite

resource "aws_security_group" "my_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id 

  
  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = [aws_vpc.my_vpc.cidr_block]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = [aws_vpc.my_vpc.cidr_block]
    }
  }
   
  

  tags = {
    Name = "my_sg"
  }

}

output "network_output" {
  value = aws_subnet.my_public_subnet.id 
}




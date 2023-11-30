# Ec2 public network
resource "aws_instance" "my_ec2" {
  ami = data.aws_ami.my_ami
  instance_type = var.type_instance
  subnet_id = var.my_public_subnet
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  
  
  #EBS stockage
  ebs_block_device {
     device_name = "/dev/sda1"
     encrypted = true
     volume_size = var.ebs_size
     delete_on_termination = true
  }

  tags = {
    Name = "my_ec2_terraform"
  }
}



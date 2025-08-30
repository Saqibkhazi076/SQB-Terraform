# Key pair
resource "aws_key_pair" "my_ec2_key_new" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("terra-key-ec2.pub")

  tags = {
	Environment = var.env
      }
}

# VPC & Security Group
resource aws_default_vpc default {

}

resource aws_security_group my_security_group {
    name = "${var.env}-infra-app-sg"
    description = "this will add a TF generated Security Group"
    vpc_id      = aws_default_vpc.default.id #interpolation

    # inbound rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH Access"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP Access"
    }

    # outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "all access open outbound"
    }

    tags = {
        Name = "${var.env}-infra-app-sg"
  }
}

# ec2 instance
resource aws_instance my_instance {
    depends_on = [
	aws_security_group.my_security_group,
	aws_key_pair.my_ec2_key_new
]
    count = var.instance_count


    key_name = aws_key_pair.my_ec2_key_new.key_name # Interpolation for keypair
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = var.instance_type
    ami = var.ec2_ami_id

    root_block_device {
      volume_size = var.env == "prd" ? 20 : 10  #20gb for prd & 10gb for dev
      volume_type = "gp3"
    }
  

  tags = {
    Name = "${var.env}-infra-app-instance"
  }
}

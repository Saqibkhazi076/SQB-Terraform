# Key pair
resource aws_key_pair deployer {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")

}

# VPC & Security Group
resource aws_default_vpc default {

}

resource aws_security_group my_security_group {
    name = "automate_sg"
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

    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Custom App Port"
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
        Name = "automate_sg"
  }
}

# ec2 instance
resource aws_instance my_instance {
    depends_on = [
	aws_security_group.my_security_group,
	aws_key_pair.deployer
]
    for_each = tomap({
	TWS-Junoon-automate-micro  = "t3.micro"
	TWS-Junoon-automate-small = "t3.small"
}) # Meta Argument

    key_name = aws_key_pair.deployer.key_name # Interpolation for keypair
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = each.value
    ami = var.ec2_ami_id
    user_data = file("install_nginx.sh")

    root_block_device {
      volume_size = var.env == "prd" ? 20 : var.aws_default_root_storage_size #20gb for prd & 10gb for dev
      volume_type = "gp3"
    }
  

  tags = {
    Name = each.key
  }
}

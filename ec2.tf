# Key Pairs (Login)

resource "aws_key_pair" my_key {
    key_name = "Terra-Key"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKJVqBuO5NnmeFAZ2wtEwcE07srB0YD1rDJGXLnZHKup ubuntu@ip-172-31-41-196"
}


# VPC & Security Group 

resource "aws_default_vpc" default {

}

# Security Group 

resource "aws_security_group" my_security_group {
    name = "Automate-SG"
    vpc_id = aws_default_vpc.default.id

    # Inbound Rules 

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Open ssh"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
        description = "Open HTTP"
    }

    ingress{
        from_port = 8000
        to_port = 8000
        protocol = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
        description = "open port 8000"
    }

    # Outound Rules

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "all outnound ports open"

    } 

}


# ec2 Instance 

resource aws_instance my_instance{
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = "t3.micro"
    ami = "ami-091138d0f0d41ff90"

    root_block_device {
      volume_size = 8 
      volume_type = "gp3"
    }   

    tags = {
        name = "Terraform-Server"
    } 

}

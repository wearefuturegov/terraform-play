resource "aws_security_group" "allow-ssh" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags {
    Name = "allow-ssh"
  }
}


resource "aws_security_group" "allow-postgres" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-postgres"
  description = "allow-postgres"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.allow-ssh.id}"]              # allowing access from our example instance
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }
  tags {
    Name = "allow-postgres"
  }
}

module "sg_ssh" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_ssh"
  security_group_name = "${var.security_group_name}-ssh"
  vpc_id = "${aws_vpc.main.id}"
  source_cidr_block = ["0.0.0.0/0"]
}

module "sg_postgresql" {
  source = "github.com/terraform-community-modules/tf_aws_sg/sg_postgresql"
  security_group_name = "${var.security_group_name}-postgresql"
  vpc_id = "${aws_vpc.main.id}"
  source_cidr_block = ["0.0.0.0/0"]
}

module "sg_web" {
 source = "github.com/terraform-community-modules/tf_aws_sg//sg_https_only"
 security_group_name = "${var.security_group_name}-https"
 vpc_id = "${aws_vpc.main.id}"
 source_cidr_block = ["0.0.0.0/0"]
}

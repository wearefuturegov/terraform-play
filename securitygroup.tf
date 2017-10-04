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

# module "sg_web" {
#  source = "github.com/terraform-community-modules/tf_aws_sg//sg_https_only"
#  security_group_name = "${var.security_group_name}-https"
#  vpc_id = "${aws_vpc.main.id}"
#  source_cidr_block = ["0.0.0.0/0"]
# }

resource "aws_security_group" "myinstance" {
  vpc_id = "${aws_vpc.main.id}"
  name = "myinstance"
  description = "security group for my instance"
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

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.elb-securitygroup.id}"]
  }

  tags {
    Name = "myinstance"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  name = "terraform_example_elb"
  vpc_id = "${aws_vpc.main.id}"
  description = "security group for load balancer"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "elb"
  }
}

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

# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name = "terraform_example_elb"
  description = "Used in the terraform"
  vpc_id = "${aws_vpc.main.id}"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# module "sg_web" {
#  source = "github.com/terraform-community-modules/tf_aws_sg//sg_https_only"
#  security_group_name = "${var.security_group_name}-https"
#  vpc_id = "${aws_vpc.main.id}"
#  source_cidr_block = ["0.0.0.0/0"]
#}

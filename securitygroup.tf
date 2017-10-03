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

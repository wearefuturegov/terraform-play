#resource "aws_elb" "terraform" {
#  name = "terraform-example-elb"
#
#  subnets = ["${aws_subnet.main-public.id}"]
#  security_groups = ["${aws_security_group.elb.id}"]
#  instances = ["${aws_instance.terraform.id}"]
#
#  listener {
#    instance_port = 80
#    instance_protocol = "http"
#    lb_port = 80
#    lb_protocol = "http"
#  }
#}
#
# # A security group for the ELB so it is accessible via the web
# resource "aws_security_group" "elb" {
#   name = "terraform_example_elb"
#   description = "Used in the terraform"
#   vpc_id = "${aws_vpc.main.id}"

#   # HTTP access from anywhere
#   ingress {
#     from_port = 80
#     to_port = 80
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # outbound internet access
#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

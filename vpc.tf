# Internet VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
      Name = "main"
    }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}


# Subnets
resource "aws_subnet" "main-public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-2a"

    tags {
        Name = "main-public"
    }
}

resource "aws_subnet" "main-private" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-west-2a"

    tags {
        Name = "main-private"
    }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "main"
    }
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-gw.id}"
    }

    tags {
        Name = "main-public"
    }
}

resource "aws_elb" "terraform" {
  name = "terraform-example-elb"

  subnets = ["${aws_subnet.main-public.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
  instances = ["${aws_instance.terraform.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
}


# route associations public
resource "aws_route_table_association" "main-public-a" {
    subnet_id = "${aws_subnet.main-public.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_key_pair" "terraform" {
  key_name = "terraform"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "terraform" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.terraform.key_name}"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # provisioner "file" {
  #   source = "scripts/yum-update.sh"
  #   destination = "/tmp/script.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh",
  #     "sudo /tmp/script.sh"
  #   ]
  # }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

  # provisioner "local-exec" {
  #   command = "cd ../chef-futuregov && knife solo bootstrap ${aws_instance.web.public_ip} -x centos -N aws1.wearefuturegov.com"
  # }

  # user data
  # user_data = "${data.template_cloudinit_config.cloudinit-example.rendered}"
}

output "ip" {
  value = "${aws_instance.terraform.public_ip}"
}

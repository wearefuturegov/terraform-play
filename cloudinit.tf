data "template_file" "shell-script" {
  template = "${file("scripts/volumes.sh")}"
  vars {
    DEVICE = "${var.INSTANCE_DEVICE_NAME}"
  }
}
data "template_cloudinit_config" "cloudinit-example" {

  gzip = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.shell-script.rendered}"
  }

}

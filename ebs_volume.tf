# resource "aws_ebs_volume" "ebs-volume-1" {
#     availability_zone = "eu-west-2a"
#     size = 20
#     type = "gp2"
#     tags {
#         Name = "extra volume data"
#     }
# }

# resource "aws_volume_attachment" "ebs-volume-1-attachment" {
#   device_name = "${var.INSTANCE_DEVICE_NAME}"
#   volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
#   instance_id = "${aws_instance.terraform.id}"
# }

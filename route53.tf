# resource "aws_route53_zone" "patchwork" {
#   name = "test.patchworkhq"
# }
# resource "aws_route53_record" "server1-record" {
#   zone_id = "${aws_route53_zone.patchwork.zone_id}"
#   name = "server1.test.patchowkhq"
#   type = "A"
#   ttl = "300"
#   records = ["${aws_eip.patchwork.public_ip}"]
# }

#resource "aws_route53_record" "www-record" {
#   zone_id = "${aws_route53_zone.patchwork.zone_id}"
#   name = "www.test.patchowkhq"
#   type = "A"
#   ttl = "300"
#   records = ["104.236.247.8"]
#}
#resource "aws_route53_record" "mail1-record" {
#   zone_id = "${aws_route53_zone.patchwork.zone_id}"
#   name = "test.patchowkhq"
#   type = "MX"
#   ttl = "300"
#   records = [
#     "1 aspmx.l.google.com.",
#     "5 alt1.aspmx.l.google.com.",
#     "5 alt2.aspmx.l.google.com.",
#     "10 aspmx2.googlemail.com.",
#     "10 aspmx3.googlemail.com."
#   ]
#}
#
#output "ns-servers" {
#   value = "${aws_route53_zone.patchwork.name_servers}"
#}

# output "eip" {
#   value = "${aws_eip.nat.public_ip}"
# }

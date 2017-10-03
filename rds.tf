resource "aws_db_subnet_group" "postgres-subnet" {
  name = "postgres-subnet"
  description = "RDS subnet group"
  subnet_ids = ["${aws_subnet.main-private-1.id}","${aws_subnet.main-private-2.id}"]
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 10    # 100 GB of storage, gives us more IOPS than a lower number
  engine               = "postgres"
  engine_version       = "9.6.2"
  instance_class       = "db.t2.micro"    # use micro if you want to use the free tier
  identifier           = "postgres"
  name                 = "postgres"
  username             = "root"   # username
  password             = "${var.RDS_PASSWORD}" # password
  db_subnet_group_name = "${aws_db_subnet_group.postgres-subnet.name}"
  multi_az             = "false"     # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids = ["${aws_security_group.allow-postgres.id}"]
  storage_type         = "gp2"
  backup_retention_period = 0    # how long you’re going to keep your backups
  # disabled till we need it
  availability_zone = "${aws_subnet.main-private-1.availability_zone}"   # prefered AZ
  tags {
      Name = "postgres-instance"
  # parameter_group_name = "${aws_db_parameter_group.postgres-parameters.name}"
  }
}

# resource "aws_db_parameter_group" "postgres-parameters" {
#   family = "postgres9.6"
#   description = "postgres parameter group"
# }

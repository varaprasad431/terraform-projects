resource "aws_elb" "prasadten" {
  name               = "prasaddigitalvibeselb"
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 5
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                 = ["${aws_instance.prasadthree.id}", "${aws_instance.prasadsix.id}"]
  cross_zone_load_balancing = true
  idle_timeout              = 400
  tags = {
    Name = "raham-tf-elb"
  }
}

  resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "14.5"
  availability_zones      = ["ap-southeast-1a", "ap-southeast-1b"]
  database_name           = "mydb"
  master_username         = "prasad"
  master_password         = "prasaddigitalvibes"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

/*resource "aws_instance" "one" {
  for_each = toset(["one", "two", "three"])
  ami           = "ami-006be9ab6a140de6e"
  instance_type = "t2.micro"
  tags = {
    Name = "instance-${each.key}"
  }
}
*/

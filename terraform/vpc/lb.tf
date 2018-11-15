resource "aws_lb" "citrusbyte-lb" {
  name               = "citrusbyte-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb_http.id}"]
  subnets            = ["${aws_subnet.public.*.id}"]

  enable_deletion_protection = true

  tags {
    Environment = "prod"
  }
}

resource "aws_lb_target_group" "app-8080" {
  name     = "app-8080-lb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
  target_type = "ip"

  health_check {
    interval = 10
    healthy_threshold = 4
    unhealthy_threshold = 2
  }

}

resource "aws_lb_listener" "http-80" {
  load_balancer_arn = "${aws_lb.citrusbyte-lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.app-8080.arn}"
  }
}

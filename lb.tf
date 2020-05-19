resource "aws_lb" "rooster" {
  name               = "rooster"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.rooster.id]
  subnets            = data.aws_subnet_ids.available.ids
}

resource "aws_lb_target_group" "rooster" {
  name     = "rooster"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.aws_vpc
}

resource "aws_lb_listener" "rooster" {
  load_balancer_arn = "${aws_lb.rooster.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.rooster.arn}"
  }
}

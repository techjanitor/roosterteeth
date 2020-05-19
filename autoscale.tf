resource "aws_launch_template" "rooster" {
  name_prefix            = "rooster"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  user_data              = filebase64("${path.module}/bootstrap")
  vpc_security_group_ids = [aws_security_group.rooster.id]
}

resource "aws_autoscaling_group" "rooster" {
  vpc_zone_identifier       = data.aws_subnet_ids.available.ids
  desired_capacity          = 3
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  target_group_arns         = [aws_lb_target_group.rooster.arn]

  launch_template {
    id      = aws_launch_template.rooster.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "rooster-scale-up" {
  name                   = "rooster-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.rooster.name}"
}

resource "aws_autoscaling_policy" "rooster-scale-down" {
  name                   = "rooster-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.rooster.name}"
}

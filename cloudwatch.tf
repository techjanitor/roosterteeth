resource "aws_cloudwatch_metric_alarm" "cpu-high" {
  alarm_name          = "cpu-util-high-rooster"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu for high utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.rooster-scale-up.arn}"
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.rooster.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu-low" {
  alarm_name          = "cpu-util-low-rooster"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 cpu for low utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.rooster-scale-down.arn}"
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.rooster.name}"
  }
}

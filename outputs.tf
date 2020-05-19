output "elb_dns" {
  value = aws_lb.rooster.dns_name
}

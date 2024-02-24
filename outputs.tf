output "time_last_deployment" {
  value = timestamp()
}

output "vpc_name" {
  value = module.vpc.name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "lb_dns" {
  value = "http://${aws_lb.app.dns_name}"
}

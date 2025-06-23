resource "aws_route53_record" "alias" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = 300
  records = ["${var.fastly_service_id}.global.prod.fastly.net"]
}
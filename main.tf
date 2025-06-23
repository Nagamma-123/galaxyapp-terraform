module "galaxyapp" {
  source = "./modules/galaxyapp"

  project_name             = var.project_name
  region                   = var.region
  bucket_name              = var.bucket_name
  domain_name              = var.domain_name
  route53_zone_id          = var.route53_zone_id
  github_repo              = var.github_repo
  github_branch            = var.github_branch
  codestar_connection_arn = var.codestar_connection_arn
  fastly_service_id        = var.fastly_service_id
  fastly_api_key_secret    = var.fastly_api_key_secret
}
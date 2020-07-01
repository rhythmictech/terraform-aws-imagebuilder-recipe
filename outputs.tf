data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

output "recipe_arn" {
  description = "ARN of the EC2 Image Builder Recipe"
  value       = "arn:aws:imagebuilder:${local.region}:${local.account_id}:image-recipe/${lower(var.name)}/${var.recipe_version}"
}

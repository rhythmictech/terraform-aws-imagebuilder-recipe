data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

output "latest_image_arn" {
  description = "ARN of the wildcard representing the latest EC2 Image Builder Image"
  value       = "arn:aws:imagebuilder:${local.region}:${local.account_id}:image/${lower(var.name)}/x.x.x"

  depends_on = [
    aws_cloudformation_stack.this
  ]
}

output "recipe_arn" {
  description = "ARN of the EC2 Image Builder Recipe"
  value       = "arn:aws:imagebuilder:${local.region}:${local.account_id}:image-recipe/${lower(var.name)}/${var.recipe_version}"

  depends_on = [
    aws_cloudformation_stack.this
  ]
}

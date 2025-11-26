output "latest_image_arn" {
  description = "ARN of the wildcard representing the latest EC2 Image Builder Image"
  value       = local.latest_image_arn
}

output "recipe_arn" {
  description = "ARN of the EC2 Image Builder Recipe"
  value       = aws_imagebuilder_image_recipe.this.arn
}

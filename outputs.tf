output "latest_image_arn" {
  description = "ARN of the wildcard representing the latest EC2 Image Builder Image"
  value       = replace(aws_imagebuilder_image_recipe.this.arn, "//[0-9]+.[0-9]+.[0-9]+$/", "/x.x.x")
}

output "recipe_arn" {
  description = "ARN of the EC2 Image Builder Recipe"
  value       = aws_imagebuilder_image_recipe.this.arn
}

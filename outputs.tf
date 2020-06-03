output "recipe_arn" {
  description = "ARN of the EC2 Image Builder Recipe"
  value       = aws_cloudformation_stack.this.outputs["RecipeArn"]
}

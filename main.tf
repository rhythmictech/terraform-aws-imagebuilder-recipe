resource "aws_cloudformation_stack" "this" {
  name               = "${var.name}-${uuid()}"
  on_failure         = "ROLLBACK"
  timeout_in_minutes = var.cloudformation_timeout

  tags = merge(
    var.tags,
    { Name : "${var.name}-stack" }
  )

  template_body = templatefile("${path.module}/cloudformation.yml.tpl", {
    block_device_mappings = var.block_device_mappings
    description           = var.description
    name                  = var.name
    parent_image          = var.parent_image
    platform              = var.platform
    update                = var.update
    version               = var.recipe_version

    components = [
      for component in var.component_arns : {
        ComponentArn = component
      }
    ]

    tags = merge(
      var.tags,
      { Name : var.name }
    )
  })

  lifecycle {
    create_before_destroy = true

    ignore_changes = [
      name
    ]
  }
}

resource "aws_cloudformation_stack" "this" {
  name               = var.name
  on_failure         = "ROLLBACK"
  timeout_in_minutes = var.timeout

  template_body = templatefile("${path.module}/cloudformation.yml.tpl", {
    block_device_mappings = var.block_device_mappings
    description           = var.description
    name                  = var.name
    parent_image          = var.parent_image
    platform              = var.platform
    update                = var.update
    version               = var.recipe_version

    components = [
      for component in var.components : {
        ComponentArn = component
      }
    ]

    tags = merge(
      var.tags,
      { Name : var.name }
    )
  })

  tags = var.tags
}

# resource "local_file" "foo" {
#   content = templatefile("${path.module}/cloudformation.yml.tpl", {
#     block_device_mappings = var.block_device_mappings
#     description           = var.description
#     name                  = var.name
#     parent_image          = var.parent_image
#     platform              = var.platform
#     update                = var.update
#     version               = var.recipe_version

#     components = [
#       for component in var.components : {
#         ComponentArn = component
#       }
#     ]

#     tags = merge(
#       var.tags,
#       { Name : var.name }
#     )
#   })
#   filename = "${path.module}/test.yml"
# }

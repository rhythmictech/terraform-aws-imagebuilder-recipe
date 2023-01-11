data "aws_region" "current" {}

locals {
  region           = data.aws_region.current.name
  update_component = var.update ? (var.platform == "Linux" ? ["arn:aws:imagebuilder:$${region}:aws:component/update-linux/x.x.x"] : ["arn:aws:imagebuilder:$${region}:aws:component/update-windows/x.x.x"]) : []
  component_arns   = concat(local.update_component, var.component_arns)
}

resource "aws_imagebuilder_image_recipe" "this" {
  name = var.name

  description       = var.description
  parent_image      = var.parent_image
  user_data_base64  = var.user_data_base64
  version           = var.recipe_version
  working_directory = var.working_directory

  systems_manager_agent {
    uninstall_after_build = var.systems_manager_agent_uninstall_after_build
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    }
  )

  dynamic "block_device_mapping" {
    for_each = var.block_device_mappings
    content {
      device_name  = lookup(block_device_mapping.value, "device_name", null)
      no_device    = lookup(block_device_mapping.value, "no_device", null)
      virtual_name = lookup(block_device_mapping.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = length(lookup(block_device_mapping.value, "ebs", {})) == 0 ? [] : [lookup(block_device_mapping.value, "ebs", {})]
        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          iops                  = lookup(ebs.value, "iops", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          throughput            = lookup(ebs.value, "throughput", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  dynamic "component" {
    for_each = local.component_arns
    content {
      component_arn = component.value
      dynamic "parameter" {
        for_each = length(lookup(var.component_parameters, component.value, [])) == 0 ? [] : lookup(var.component_parameters, component.value, [])
        content {
          name  = lookup(parameter.value, "name", null)
          value = lookup(parameter.value, "value", null)
        }
      }
    }
  }
}

# terraform-aws-imagebuilder-recipe [![](https://github.com/rhythmictech/terraform-aws-imagebuilder-recipe/workflows/pre-commit-check/badge.svg)](https://github.com/rhythmictech/terraform-aws-imagebuilder-recipe/actions) <a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=RhythmicTech" alt="follow on Twitter"></a>
Creates EC2 Image Builder recipes

## Example
Here's what using the module will look like
```hcl
module "test_recipe" {
  source  = "rhythmictech/imagebuilder-recipe/aws"
  version = "~> 0.2.0"

  description    = "Testing recipe"
  name           = "test-recipe"
  parent_image   = "arn:aws:imagebuilder:us-east-1:aws:image/amazon-linux-2-x86/x.x.x"
  recipe_version = "1.0.0"
  tags           = local.tags
  update         = true

  component_arns = [
    module.test_component.component_arn,
    "arn:aws:imagebuilder:us-east-1:aws:component/simple-boot-test-linux/1.0.0/1",
    "arn:aws:imagebuilder:us-east-1:aws:component/reboot-test-linux/1.0.0/1"
  ]
}
```

## About
Creates EC2 Image Builder recipes

## Component Parameters (experimental)
In our experience we haven't needed to provide parameters to the components we include in an Image Builder recipe, so the easiest use case has been to simply include a list of ARNs (component_arns variable).  If you need to provide parameters, you can use the separate component_parameters map, e.g.
```hcl
  component_arns = [
    module.test_component.component_arn,
    "arn:aws:imagebuilder:us-east-1:aws:component/simple-boot-test-linux/1.0.0/1",
    "arn:aws:imagebuilder:us-east-1:aws:component/reboot-test-linux/1.0.0/1"
  ]

  component_parameters = [
    { 
      module.test_component.component_arn = [
        { "param1" = "value1"},
        { "param2" = "value2"}
      ],
    },
    { 
      "arn:aws:imagebuilder:us-east-1:aws:component/simple-boot-test-linux/1.0.0/1" = [
        { "param1" = "value1"}
      ],
    }
  ]

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.44 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_imagebuilder_image_recipe.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_image_recipe) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings) | [List of Maps of EBS volumes to mount](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-imagebuilder-imagerecipe-instanceblockdevicemapping.html) See examples for further usage tips. | `list(any)` | `null` | no |
| <a name="input_cloudformation_timeout"></a> [cloudformation\_timeout](#input\_cloudformation\_timeout) | How long to wait (in minutes) for CFN to apply before giving up | `number` | `10` | no |
| <a name="input_component_arns"></a> [component\_arns](#input\_component\_arns) | List of component ARNs to use in recipe. Order matters | `list(string)` | n/a | yes |
| <a name="input_component_parameters"></a> [component\_parameters](#input\_component\_parameters) | A map of component arns (as specified in component\_arns) that contains a list of maps of parameters (each parameter contains a name and a value) to apply to the component | `map(list(map(string)))` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | description of component | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | name to use for component | `string` | n/a | yes |
| <a name="input_parent_image"></a> [parent\_image](#input\_parent\_image) | Image that the recipe should start with. SemVers is ok (and encouraged) | `string` | n/a | yes |
| <a name="input_platform"></a> [platform](#input\_platform) | Platform of Recipe (`Linux` or `Windows`) | `string` | `"Linux"` | no |
| <a name="input_recipe_version"></a> [recipe\_version](#input\_recipe\_version) | Version of the recipe | `string` | n/a | yes |
| <a name="input_systems_manager_agent_uninstall_after_build"></a> [systems\_manager\_agent\_uninstall\_after\_build](#input\_systems\_manager\_agent\_uninstall\_after\_build) | Boolean value for whether or not the systems manager agent should be uninstall from the image after it is built | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to use for CFN stack and component | `map(string)` | `{}` | no |
| <a name="input_update"></a> [update](#input\_update) | Whether recipe should include the `update-$platform` recipe before running other components | `bool` | `true` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | Base64 Encoded user-data to provide when spinning up the build instance. | `bool` | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | Working directory to use in the build instance. ImageBuilder uses /tmp by default on Linux, which can be an issue when working with CIS-hardened images. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_latest_image_arn"></a> [latest\_image\_arn](#output\_latest\_image\_arn) | ARN of the wildcard representing the latest EC2 Image Builder Image |
| <a name="output_recipe_arn"></a> [recipe\_arn](#output\_recipe\_arn) | ARN of the EC2 Image Builder Recipe |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants underneath this module
- pre-commit.com/
- terraform.io/
- github.com/tfutils/tfenv
- github.com/segmentio/terraform-docs

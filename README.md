# terraform-aws-imagebuilder-recipe [![](https://github.com/rhythmictech/terraform-aws-imagebuilder-recipe/workflows/pre-commit-check/badge.svg)](https://github.com/rhythmictech/terraform-aws-imagebuilder-recipe/actions) <a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=RhythmicTech" alt="follow on Twitter"></a>
Creates EC2 Image Builder recipes by wrapping CloudFormation

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
Creates EC2 Image Builder recipes by wrapping CloudFormation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.2 |
| aws | >= 2.44 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.44 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_arns | List of component ARNs to use in recipe. Order matters | `list(string)` | n/a | yes |
| name | name to use for component | `string` | n/a | yes |
| parent\_image | Image that the recipe should start with. SemVers is ok (and encouraged) | `string` | n/a | yes |
| recipe\_version | Version of the recipe | `string` | n/a | yes |
| block\_device\_mappings | [List of Maps of EBS volumes to mount](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-imagebuilder-imagerecipe-instanceblockdevicemapping.html) See examples for further usage tips. | `list(any)` | `null` | no |
| cloudformation\_timeout | How long to wait (in minutes) for CFN to apply before giving up | `number` | `10` | no |
| description | description of component | `string` | `null` | no |
| platform | Platform of Recipe (`Linux` or `Windows`) | `string` | `"Linux"` | no |
| tags | Map of tags to use for CFN stack and component | `map(string)` | `{}` | no |
| update | Whether recipe should include the `update-$platform` recipe before running other components | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| latest\_image\_arn | ARN of the wildcard representing the latest EC2 Image Builder Image |
| recipe\_arn | ARN of the EC2 Image Builder Recipe |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants underneath this module
- pre-commit.com/
- terraform.io/
- github.com/tfutils/tfenv
- github.com/segmentio/terraform-docs

# basic example

## Code
```hcl
module "test_recipe" {
  source  = "../../"

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

## Applying
```
>  terraform apply

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

recipe_arn = arn:aws:imagebuilder:us-east-1:000000000000:image-pipeline/test-pipeline
```

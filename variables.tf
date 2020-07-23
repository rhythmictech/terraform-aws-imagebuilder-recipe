variable "block_device_mappings" {
  default     = null
  description = "[List of Maps of EBS volumes to mount](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-imagebuilder-imagerecipe-instanceblockdevicemapping.html)"

  type = list(
    object({
      DeviceName  = string
      Ebs         = map(any)
      NoDevice    = string
      VirtualName = string
    })
  )
}

variable "cloudformation_timeout" {
  default     = 10
  description = "How long to wait (in minutes) for CFN to apply before giving up"
  type        = number
}

variable "component_arns" {
  description = "List of component ARNs to use in recipe. Order matters"
  type        = list(string)
}

variable "description" {
  default     = null
  description = "description of component"
  type        = string
}

variable "name" {
  description = "name to use for component"
  type        = string
}

variable "parent_image" {
  description = "Image that the recipe should start with. SemVers is ok (and encouraged)"
  type        = string
}

# TODO: add validation
variable "platform" {
  default     = "Linux"
  description = "Platform of Recipe (`Linux` or `Windows`)"
  type        = string
}

variable "recipe_version" {
  description = "Version of the recipe"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Map of tags to use for CFN stack and component"
  type        = map(string)
}

variable "update" {
  default     = true
  description = "Whether recipe should include the `update-$platform` recipe before running other components"
  type        = bool
}

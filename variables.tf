variable "block_device_mappings" {
  default     = []
  description = "[List of Maps of EBS volumes to mount](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-imagebuilder-imagerecipe-instanceblockdevicemapping.html) See examples for further usage tips."
  type        = list(any)
}

variable "component_arns" {
  description = "List of component ARNs to use in recipe. Order matters"
  type        = list(string)
}

variable "component_parameters" {
  default     = {}
  description = "(Experimental) A map of component arns (as specified in component_arns) that contains a list of maps of parameters (each parameter contains a name and a value) to apply to the component"
  type        = map(list(map(string)))
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

variable "systems_manager_agent_uninstall_after_build" {
  default     = false
  description = "Boolean value for whether or not the systems manager agent should be uninstall from the image after it is built"
  type        = bool
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

variable "user_data_base64" {
  default     = null
  description = "Base64 Encoded user-data to provide when spinning up the build instance."
  type        = bool
}

variable "working_directory" {
  default     = null
  description = "Working directory to use in the build instance. ImageBuilder uses /tmp by default on Linux, which can be an issue when working with CIS-hardened images."
  type        = string
}

Resources:
  ImageBuildRecipe:
    Type: AWS::ImageBuilder::ImageRecipe
    UpdateReplacePolicy: Retain
    Properties:
      %{~ if block_device_mappings != null ~}
      BlockDeviceMappings:
        ${ indent(8, chomp(yamlencode(block_device_mappings))) }
      %{~ endif ~}
      Name: ${name}
      Version: ${version}
      %{~ if description != null ~}
      Description: ${description}
      %{~ endif ~}
      Components:
        %{~ if update == true ~}
          %{~ if platform == "Linux" ~}
        ${ indent(8, chomp(yamlencode([{ComponentArn: "arn:aws:imagebuilder:${region}:aws:component/update-linux/x.x.x"}])))}
          %{~ else ~}
        ${ indent(8, chomp(yamlencode([{ComponentArn: "arn:aws:imagebuilder:${region}:aws:component/update-windows/x.x.x"}])))}
          %{~ endif ~}
        %{~ endif ~}
        ${ indent(8, chomp(yamlencode(components)))}
      ParentImage: ${parent_image}
      Tags:
        ${ indent(8, chomp(yamlencode(tags))) }
Outputs:
  RecipeArn:
    Description: ARN of the created component
    Value: !Ref "ImageBuildRecipe"

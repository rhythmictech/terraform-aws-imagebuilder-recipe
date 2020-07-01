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
        ${ indent(8, chomp(yamlencode([{ComponentArn: "arn:aws:imagebuilder:us-east-1:aws:component/update-linux/1.0.0"}])))}
          %{~ else ~}
        ${ indent(8, chomp(yamlencode([{ComponentArn: "arn:aws:imagebuilder:us-east-1:aws:component/update-windows/1.0.0"}])))}
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

Generates CloudFormation template, parameter files, and scripts in lono project and writes them to the `output` folder.

## Examples

    lono generate BLUEPRINT
    lono generate BLUEPRINT --clean
    lono g BLUEPRINT --clean # shortcut

## Example Output

    $ lono generate ec2
    Generating CloudFormation templates, parameters, and scripts
    Generating CloudFormation templates:
      output/templates/ec2.yml
    Generating parameter files:
      output/params/ec2.json
    $

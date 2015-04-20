# Set Required Variables:

`region="us-west-2"`

`key_name="cjohnson"`

`your_name="cjohnson"`

# Validate CloudFormation
`aws cloudformation validate-template --template-body file://vpc-with-webserver-asg.json --region $region`

# Create the VPC and Web Server Stack
`aws cloudformation create-stack --stack-name cloudformation-$your_name --parameters ParameterKey=KeyName,ParameterValue=$key_name ParameterKey=webServerInstanceType,ParameterValue=t2.micro --template-body file://vpc-with-webserver-asg.json --region $region`

# Update the VPC and Web Server Stack
`aws cloudformation update-stack --stack-name cloudformation-$your_name --parameters ParameterKey=KeyName,ParameterValue=$key_name ParameterKey=webServerInstanceType,ParameterValue=t2.small --template-body file://vpc-with-webserver-asg.json --region $region`

# Delete the VPC and Web Server Stack
`aws cloudformation delete-stack --stack-name cloudformation-$your_name --region $region`

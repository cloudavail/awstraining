# AWS Intro
## List all AWS Regions
`aws ec2 describe-regions --output text`

## List all EC2 Instances
`aws ec2 describe-instances`

Will return a list of EC2 instances from your default region.

## List all EC2 Instances, Text Format
`aws ec2 describe-instances --output text`

Will return a list of EC2 instances from the default region in text format.

## List all EC2 Instances, Specific Region and Text Format
`aws ec2 describe-instances --region us-west-2 --output text`

Will return a list of EC2 instances from the us-east-1 region in text format.

## List all EC2 Instances, Specific Region and Table Format
`aws ec2 describe-instances --region us-west-2 --output table`
Will return a list of EC2 instances from the us-east-1 region in table format.

## List specific EC2 Instances based on Size, Specific Region and Text Format
Note that you may need to change "Values" from `t2.micro` to `m3.medium` or another size instance that is used within the AWS account that you are currently using.

`aws ec2 describe-instances --filter "Name=instance-type,Values=t2.micro" --region us-west-2 --output table`

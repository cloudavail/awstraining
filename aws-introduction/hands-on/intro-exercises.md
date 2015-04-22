# List all AWS Regions
AWS is made up of a number of regions - you can view these regions by running the following command:

`aws ec2 describe-regions --output text`

# List all of a particular type of Resouce:
Nearly every resource on AWS is able to be accessed via an API call and via the AWS CLI tool. An example call listing all EC2 instances in your default region is below:

`aws ec2 describe-instances`

A similar command can be used to list all available RDS (Relational Database) Instances. This command is below:

`aws rds describe-db-instances`

# List all EC2 Instances, Text Format
The AWS CLI tool also allow you to format output to be human readable, either in text or table format:

1. `aws ec2 describe-instances --output text`
2. `aws ec2 describe-instances --output table`

Either format can be easy to read. The text format is particularly useful for piping output from one command to another.

# List all EC2 Instances, Specific Region and Text Format
Many AWS customers utilize multiple regions for their AWS resources (we will explain why later) - the command below will be identify EC2 instances running in the `us-west-2` region and output in `text` format.

`aws ec2 describe-instances --region us-west-2 --output text`

You could run the `aws ec2 describe-instances` command in other regions as well:

`aws ec2 describe-instances --region eu-west-1 --output text`

## List specific EC2 Instances based on Size, Specific Region and Text Format
Note that many commands run by the AWS Command Line Interface support filtering - the parameter below will limit results to only instances of type `t2.micro`.

`aws ec2 describe-instances --filter "Name=instance-type,Values=t2.micro" --region us-west-2 --output table`

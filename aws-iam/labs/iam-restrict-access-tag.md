# Overview

This exercise will restrict the "Start", "Stop", "Terminate" and "Reboot" actions to only EC2 instances with a tag of `"Key=Owner,Value=$username"` where username is equal to the given user's AWS IAM username.

Note - I've been unable to find details of the Tag infrastructure being eventually consistent - other AWS Service APIs are eventually consistent (http://docs.aws.amazon.com/AWSEC2/latest/APIReference/query-api-troubleshooting.html#eventual-consistency). My experience has been that tags can take a while to be assigned to newly created resources.

# Set Variables

`your_name="cjohnson"`

`your_password="my_password"`

# Create a Limited Access IAM user

## Create a User Account

`aws iam create-user --user-name limited-$your_name`

## Set Password and Allow Login to the AWS Console

`aws iam create-login-profile --user-name limited-$your_name --password $your_password`

## Put the User Account Policy
Note: you must run this command from the directory that contains the file "ec2-dev-tag-only.json" or update the parameter 

`aws iam put-user-policy --user-name limited-$your_name --policy-name ec2-development-access --policy-document file://ec2-dev-tag-only.json`

# Test the Resulting Permission:

Note: the remainder of this should be done as the previously created IAM user and through the AWS Console.

## Get the AWS Console URL

`account_alias=$(aws iam list-account-aliases --output text --query AccountAliases)`

`echo "The IAM Login URL is: https://$account_alias.signin.aws.amazon.com/console/"

# Attempt to Start/Stop/Reboot/Terminate Instances

1. Actions will not be authorized if the given EC2 instance has no tag.
2. Start/Stop/Terminate/Reboot actions will be authorized if the given EC2 instance has a tag with `Key=Owner,Value=$username`

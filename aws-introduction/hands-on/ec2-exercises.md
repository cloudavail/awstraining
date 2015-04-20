# Create an EC2 Instance
## Set Required Variables:

`region="us-west-2"`

`vpc_id="vpc-f38d3796"`

`subnet_id="subnet-7a94061f"`

Lastly, set a variable containing your name:

`your_name="cjohnson"`

## Create an EC2 Security Group
`aws ec2 create-security-group --group-name www-$your_name --description "security group for www-$your_name servers" --vpc-id $vpc_id --region $region`

If run correctly, you should see a Security Group ID is returned:

    {
        "GroupId": "sg-26313c43"
    }

And set the security group variable:

`security_group_id="sg-26313c43"`

Or, if you wanted a shorter method for doing this you can capture the output of the `aws ec2 create-security-group` command as the variable security_group_id. An example is below:

`security_group_id=$(aws ec2 create-security-group --group-name www-$your_name --description "security group for www-$your_name servers" --vpc-id $vpc_id --region $region --output text)`

## Create an EC2 Instance

`aws ec2 run-instances --image-id ami-5189a661 --region $region --instance-type t2.micro --security-group-id $security_group_id --subnet-id $subnet_id --associate-public-ip-address --output table`

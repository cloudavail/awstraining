# Set Required Variables:

`region="us-west-2"`

`vpc_id="vpc-f38d3796"`

`subnet_id="subnet-7a94061f"`

`your_name="cjohnson"`

# Create an EC2 Security Group
The command below will:

1. Create a Security Group named "www-$yourname"
2. Place this Security Group in the VPC ID $vpc_id and in the Region $region. 

`aws ec2 create-security-group --group-name www-$your_name --description "security group for www-$your_name servers" --vpc-id $vpc_id --region $region`

If run correctly, you should see a Security Group ID is returned:

    {
        "GroupId": "sg-26313c43"
    }

And set the security group variable:

`security_group_id="sg-26313c43"`

Or, if you wanted a shorter method for doing this you can capture the output of the `aws ec2 create-security-group` command as the variable security_group_id. An example is below:

`security_group_id=$(aws ec2 create-security-group --group-name www-$your_name --description "security group for www-$your_name servers" --vpc-id $vpc_id --region $region --output text)`

# Create an EC2 Instance
The command below will:

1. Run (meaning startup) an EC2 Instance.
2. Use the "AMI ID" ami-5189a661 - this AMI ID is an Ubuntu Server 14.04 AMI.
3. Use the Instance Type of t2.micro - this is a less expensive but less powerful EC2 instance type.
4. Make the newly run instance a member of the previously created "www-$yourname" Security Group.
5. Place this instance in the Subnet ID $subnet_id.
6. Associate a Public IP Address - for now - a Public IP address is required for an instance to receive packets from Internet Gateway - we'll explore alternative options for Internet connectivity in other modules.

`aws ec2 run-instances --image-id ami-5189a661 --region $region --instance-type t2.micro --security-group-id $security_group_id --subnet-id $subnet_id --associate-public-ip-address --output table`

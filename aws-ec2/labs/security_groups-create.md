# Set Required Variables:

`region="us-west-2"`

`vpc_id="vpc-f38d3796"`

`your_name="cjohnson"`

# Create the Gateway Security Group

## Create the Gateway Security Group
The command below will create a the Security Group for the Gateway instance - the command below will:

1. Create a Security Group named gateway-$your_name
2. Create the Security Group in the VPC $vpc_id
3. Create the Security Group in the region $region

`gateway_security_group_id=$(aws ec2 create-security-group --group-name gateway-$your_name --description "security group for gateway-$your_name servers" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the gateway security group is: $gateway_security_group_id."`

## Authorize ssh 0.0.0.0/0 ingress for the Gateway Security Group

In the previous step, we created the Security Group gateway-$your_name. We did not create any ingress rules in the previous step - running the command below will create an ingress rule that allows port 22 in from anywhere on the Internet (0.0.0.0/0).

`aws ec2 authorize-security-group-ingress --group-id $gateway_security_group_id --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $region`

and confirm the result:

`aws ec2 describe-security-groups --group-id $gateway_security_group_id --region $region --output table`

We will use this group once more in a later step - in particular, we will allow EC2 instances that are members of the gateway-$your_name Security Group to access EC2 instances that are members of the base-$your_name Security Group.

# Create the base-$your_name Security Group

## Create the base-$your_name Security Group
The command below will create a the "base" Security Group of which a majority of our EC2 Instances will be members - the command below will:

1. Create a Security Group named base-$your_name
2. Create the base-$your_name Security Group in the VPC $vpc_id
3. Create the base-$your_name Security Group in the region $region

`base_security_group_id=$(aws ec2 create-security-group --group-name base-$your_name --description "security group allowing common inbound traffic for all servers" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the base security group is: $base_security_group_id."`

## Authorize gateway Host SSH ingress for the base-$your_name Security Group

By running the command below, we allow all EC2 instances that are members of the "gateway-$your_name" Security Group to ssh into instances. The practical outcome: anyone accessing the "gateway-prod01" server can access all other EC2 instances that are members of the "base-$your_name" Security Group.

`aws ec2 authorize-security-group-ingress --group-id $base_security_group_id --protocol tcp --port 22 --source-group $gateway_security_group_id --region $region`

and confirm the result:

`aws ec2 describe-security-groups --group-id $base_security_group_id --region $region --output table`

# Create the www Security Group

## Create the www Security Group

`www_security_group_id=$(aws ec2 create-security-group --group-name www-$your_name --description "security group for www-$your_name servers" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the www security group is: $www_security_group_id."`

## Authorize www Ingress for the Gateway Security Group

`aws ec2 authorize-security-group-ingress --group-id $www_security_group_id --protocol tcp --port 80 --cidr 0.0.0.0/0 --region us-west-2`

and confirm the result:

`aws ec2 describe-security-groups --group-id $www_security_group_id --region us-west-2 --output table`

# Review:

You've created three Security Groups, which will ultimately allow:

1. gateway-$your_name: allowing port 22 ingress from 0.0.0.0/0
2. base-$your_name: allowing port 22 ingress from the "Gateway" host.
3. www-$your_name: allowing port 80 ingress from 0.0.0.0/0.

At this point, we'd suggest going into the AWS Console and reviewing to make sure that the three security groups above have been created.

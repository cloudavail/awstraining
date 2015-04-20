# Create Security Groups

## Set Required Variables:

`region="us-west-2"`

`vpc_id="vpc-f38d3796"`

`your_name="cjohnson"`

## Create the Gateway Security Group

`gateway_security_group_id=$(aws ec2 create-security-group --group-name gateway-$your_name --description "security group for gateway-$your_name servers" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the gateway security group is: $gateway_security_group_id."`

## Authorize ssh Ingress for the Gateway Security Group

`aws ec2 authorize-security-group-ingress --group-id $gateway_security_group_id --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $region`

and confirm the result:

`aws ec2 describe-security-groups --group-id $gateway_security_group_id --region $region --output table`

## Create the base Security Group

`base_security_group_id=$(aws ec2 create-security-group --group-name base --description "security group allowing common inbound traffic for all servers" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the base security group is: $base_security_group_id."`

## Authorize gateway Host SSH Ingress for the Base Security Group

`aws ec2 authorize-security-group-ingress --group-id $base_security_group_id --protocol tcp --port 22 --source-group $gateway_security_group_id --region $region`

and confirm the result:

`aws ec2 describe-security-groups --group-id $base_security_group_id --region $region --output table`

## Create the www Security Group

`www_security_group_id=$(aws ec2 create-security-group --group-name www-$your_name --description "security group for www-$your_name servers" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the www security group is: $www_security_group_id."`

## Authorize www Ingress for the Gateway Security Group

`aws ec2 authorize-security-group-ingress --group-id $www_security_group_id --protocol tcp --port 80 --cidr 0.0.0.0/0 --region us-west-2`

and confirm the result:

`aws ec2 describe-security-groups --group-id $www_security_group_id --region us-west-2 --output table`

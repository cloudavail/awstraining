# Create EC2 Instances

## Before You Begin
Create and save a keypair. Make sure to set the permissions on this keypair to ready only: `chmod 400 ~/path/to/keypair.pem`. Set the `keypair_name` variable to the name of this keypair.

`key_name="cjohnson-test"`

## Set Additional Variables:

`region="us-west-2"`

`subnet_id="subnet-7a94061f"`

## Create the Gateway EC2 Instance

`gateway_instance_id=$(aws ec2 run-instances --image-id ami-5189a661 --key-name $key_name --region $region --instance-type t2.micro --security-group-ids $gateway_security_group_id --subnet-id $subnet_id --associate-public-ip-address --output text --query 'Instances[*].InstanceId')`

and confirm that the Gateway Instance has been launched:

`echo "The instance ID of the gateway EC2 Instance is: $gateway_instance_id."`

## Tag the Gateway EC2 Instance

`aws ec2 create-tags --resources $gateway_instance_id --tags Key="Name",Value="gateway-$your_name" --region $region`

## Create the www EC2 Instance

`www_instance_id=$(aws ec2 run-instances --image-id ami-5189a661 --key-name $key_name --region $region --instance-type t2.micro --security-group-ids $www_security_group_id $base_security_group_id --subnet-id $subnet_id --associate-public-ip-address --output text --query 'Instances[*].InstanceId')`

and confirm that the www Instance has been launched:

`echo "The instance ID of the www EC2 Instance is: $www_instance_id."`

## Tag the www EC2 Instance

`aws ec2 create-tags --resources $www_instance_id --tags Key="Name",Value="www-$your_name" --region $region`

# ssh to the www Instance
Note: in broad strokes, here is what we are doing:

1. adding the key to your SSH Forwarding Agent
2. getting the IP addresses of both the gateway and www Server
3. logging into the www Server by first sshing into gateway Server

## Enable ssh Agent Forwarding of your new keypair:

`ssh-add ~/path/to/keypair.pem`

## Get IP Addresses of Each Instance

`gateway_public_ip=$(aws ec2 describe-instances --instance-id $gateway_instance_id --region $region --output text --query Reservations[*].Instances[*].PublicIpAddress)`

and confirm the Gateway Server Public IP Address:

`echo "The Public IP Address of the gateway EC2 Instance is: $gateway_public_ip."`

`www_private_ip=$(aws ec2 describe-instances --instance-id $www_instance_id --region $region --output text --query Reservations[*].Instances[*].PrivateIpAddress)`

and confirm the www Server Private IP Address:

`echo "The Private IP Address of the www EC2 Instance is: $www_private_ip."`

## And Login to the www Server

`ssh -A -t ubuntu@$gateway_public_ip ssh -t ubuntu@$www_private_ip`

## And Install Apache

`sudo apt-get -y install apache2`

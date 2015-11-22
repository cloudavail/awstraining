# Overview:
Note: in broad strokes, here is what we are doing:

1. adding the key to your SSH Forwarding Agent
2. getting the IP addresses of both the gateway and www Server
3. logging into the www Server by first sshing into gateway Server

# Prerequsities:

1. Have completed both `security_groups-create.md` and `ec2-create-instances.md`.

# Confirm Variables Set:
Before proceding, we will want to make sure that all required variables are set - you can do this by running the commands below:

`echo "The Gateway Server's Instance ID is: $gateway_instance_id`

`echo "The www Server's Instance ID is: $www_instance_id`

## Enable ssh Agent Forwarding of your new keypair:
There are a few different ways to access the www Host that we have created when using ssh - we'll be using ssh Agent Forwarding and an SSH tunnel to accomplish this. Instructions for adding your keys to the ssh Authentication Agent are below:

`ssh-add ~/path/to/keypair.pem`

To confirm ssh-forwarding is working correctly, run the `ssh-add -l` command. This command should list the keypair that you had created previously - an example is below:

    cjohnson04:~ cjohnson$ ssh-add -l
    2048 3e:be:78:c9:4a:ad:d2:4f:83:09:4f:80:b1:9b:02:41 /Users/cjohnson/Downloads/cjohnson.pem (RSA)

## Get Public IP Addresses of the Gateway Instance

The `aws ec2 describe-instances` command below will return the Public IP address of the gateway-$your_name server - we'll need this server's public IP address in order to ssh into our Amazon infrastructure.

`gateway_public_ip=$(aws ec2 describe-instances --instance-id $gateway_instance_id --region $region --output text --query Reservations[*].Instances[*].PublicIpAddress)`

and confirm the Gateway Server Public IP Address:

`echo "The Public IP Address of the gateway EC2 Instance is: $gateway_public_ip."`

## Get Private IP Addresses of the Gateway Instance

The `aws ec2 describe-instances` command below will return the Private IP address of the www-$your_name server - we will be ssh'ing from the private IP address of the Gateway server to the private IP address of the WWW server. In other words - our ssh sesssion will not travel over the Public Internet.

`www_private_ip=$(aws ec2 describe-instances --instance-id $www_instance_id --region $region --output text --query Reservations[*].Instances[*].PrivateIpAddress)`

and confirm the www Server Private IP Address:

`echo "The Private IP Address of the www EC2 Instance is: $www_private_ip."`

# Lastly, Login to the www Server

`ssh -A -t ubuntu@$gateway_public_ip ssh -t ubuntu@$www_private_ip`

# And Install Apache2 on the www Server

Lastly - we will want to install Apache2 on our www Server.

`sudo apt-get -y install apache2`

# Before You Begin:

set variables for future use:

`region="us-west-2"`

`subnet_id="subnet-7a94061f"`

# Create EC2 Instances using User-Data

## Create the wwwauto EC2 Instance using User-Data
Note: you must provide the path to the `ec2-user-data.sh` file as part of the `aws ec2 run-instances` command.

`wwwauto_instance_id=$(aws ec2 run-instances --image-id ami-5189a661 --key-name $key_name --region $region --instance-type t2.micro --security-group-ids $www_security_group_id $base_security_group_id --subnet-id $subnet_id --associate-public-ip-address --user-data file://ec2-user-data.sh --output text --query 'Instances[*].InstanceId')`

and confirm that the wwwauto Instance has been launched:

`echo "The instance ID of the wwwauto EC2 Instance is: $wwwauto_instance_id."`

## Tag the wwwauto EC2 Instance

`aws ec2 create-tags --resources $wwwauto_instance_id --tags Key="Name",Value="wwwauto-$your_name" --region $region`

# Browse to the Public IP Address of the wwwauto Instance:

## Get Public IP Addresses of the wwwauto Instance

`aws ec2 describe-instances --instance-id $wwwauto_instance_id --region $region --output text --query Reservations[*].Instances[*].PublicIpAddress`

## Browse to the Public IP Address Returned Above:

Note that this may take up to a minute to install and start the Apache web server.

1. Open a browser window.
2. Enter the public IP address returned above.

# Before you Begin:

set variables for future use:

`region="us-west-2"`

`availability_zone="us-west-2a"`

`www_public_ip=$(aws ec2 describe-instances --instance-id $www_instance_id --region $region --query Reservations[*].Instances[*].PublicIpAddress --output text)`

Confirm that the Public IP of a given instance has been returned:

`echo "The public IP of the www Server is: $www_public_ip."`


# Create and Attached EBS Volume

`www_public_ip=$(aws ec2 describe-instances --instance-id $www_instance_id --region $region --query Reservations[*].Instances[*].PublicIpAddress --output text)`

Confirm that the Public IP of a given instance has been returned:

`echo "The public IP of the www Server is: $www_public_ip."`

## Create a new EBS Volume for the www Instance

`ebs_volume_id=$(aws ec2 create-volume --size 20 --volume-type gp2 --availability-zone $availability_zone --region $region --output text --query VolumeId)`

and confirm that the ebs Volume has been created:

`echo "The volume ID of the new EBS Volume is: $ebs_volume_id."`

## Attach the new EBS Volume to the www Instance

`aws ec2 attach-volume --volume-id $ebs_volume_id --instance-id $www_instance_id --device /dev/sdf --region $region`

# Format the new EBS Volume

## Login to the www-yourname Server

`ssh -i ~/path/to/keyfile.pem ubuntu@$www_public_ip`

## Format the newly attached EBS volume:

    sudo su -
    mkfs -t ext4 /dev/xvdf
    mkdir -p /srv/yourname
    mount /dev/xvdf /srv/yourname

## Confirm that the newly attached EBS Volume is Available:

Report File System Space Usage using df

`df -h`

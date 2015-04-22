# Prerequisites:

Create and save a keypair. Make sure to set the permissions on this keypair to ready only: `chmod 400 ~/path/to/keypair.pem`. Set the `keypair_name` variable to the name of this keypair.

# Set Required Variables:

`key_name="cjohnson-test"`

`your_name="cjohnson"`

`vpc_id="vpc-f38d3796"`

`region="us-west-2"`

`availability_zone="us-west-2a"`

`subnet_id="subnet-7a94061f"`

# Create the EBS Test Security Group

`ebs_test_security_group_id=$(aws ec2 create-security-group --group-name ebstest-$your_name --description "security group for ebstest-$your_name servers" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the EBS Test security group is: $ebs_test_security_group_id."`

`aws ec2 authorize-security-group-ingress --group-id $ebs_test_security_group_id --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $region`

# Create two EBS Volumes

`gp2_volume_id=$(aws ec2 create-volume --size 80 --volume-type gp2 --availability-zone $availability_zone --region $region --output text --query VolumeId)`

`io1_volume_id=$(aws ec2 create-volume --size 400 --volume-type io1 --iops 12000 --availability-zone $availability_zone --region $region --output text --query VolumeId)`

# Create the EBS Test EC2 Instance

A c4.xlarge is capable of delivering 2000 mpbs (mbits) of EBS throughput or 250 MB/s maximum bandwidth. From: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSOptimized.html.

`ebs_test_id=$(aws ec2 run-instances --image-id ami-5189a661 --key-name $key_name --region $region --instance-type c4.4xlarge --security-group-ids $ebs_test_security_group_id --subnet-id $subnet_id --associate-public-ip-address --output text --query 'Instances[*].InstanceId')`

and confirm that the EBS Test Instance has been launched:

`echo "The instance ID of the EBS Test EC2 Instance is: $ebs_test_id."`

## Tag the EBS Test EC2 Instance

`aws ec2 create-tags --resources $ebs_test_id --tags Key="Name",Value="ebstest-$your_name" --region $region`

# Attach two EBS Volumes

Note that you may need to wait a minute for the ebs_test instance to enter "Running" state.

`aws ec2 attach-volume --volume-id $gp2_volume_id --instance-id $ebs_test_id --device /dev/sdf --region $region`

`aws ec2 attach-volume --volume-id $io1_volume_id --instance-id $ebs_test_id --device /dev/sdg --region $region`

# ssh to the EBS Test Instance

## Get IP Addresses of EBS Test Instance

`ebs_test_public_ip=$(aws ec2 describe-instances --instance-id $ebs_test_id --region $region --output text --query Reservations[*].Instances[*].PublicIpAddress)`

and confirm the EBS Test Instance Public IP Address:

`echo "The Public IP Address of the EBS Test EC2 Instance is: $ebs_test_public_ip."`

## And Login to the EBS Test Instance

`ssh -i ~/path/to/keyfile.pem ubuntu@$ebs_test_public_ip`

## Format the newly attached EBS volumes:

    sudo su -
    mkfs -t ext4 /dev/xvdf
    mkdir -p /srv/gp2
    mount /dev/xvdf /srv/gp2

    mkfs -t ext4 /dev/xvdg
    mkdir -p /srv/io1
    mount /dev/xvdg /srv/io1

    These simply take too long to run:
    umount /dev/xvdf
    dd if=/dev/zero of=/dev/xvdf bs=1M
    umount /dev/xvdg
    dd if=/dev/zero of=/dev/xvdg bs=1M

    apt-get -y install bonnie++

    bonnie++ -u root -d /srv/gp2 -s 62000
    bonnie++ -u root -d /srv/io1 -s 62000

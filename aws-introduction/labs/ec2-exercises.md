# Set Required Variables:

`region="us-west-2"`

`vpc_id="vpc-f38d3796"`

`subnet_id="subnet-7a94061f"`

`your_name="cjohnson"`

# Create an EC2 Key Pair
Note that the command below will create a keypair in the current working directory.

`aws ec2 create-key-pair --key-name $your_name --output text --query KeyMaterial --region $region > $your_name.pem`

# Create an EC2 Security Group
The command below will:

1. Create a Security Group named "test-$yourname"
2. Place this Security Group in the VPC ID $vpc_id and in the Region $region. 

`aws ec2 create-security-group --group-name test-$your_name --description "security group for test-$your_name servers" --vpc-id $vpc_id --region $region`

If run correctly, you should see a Security Group ID is returned:

    {
        "GroupId": "sg-26313c43"
    }

And set the security group variable:

`test_security_group_id="sg-26313c43"`

Or, if you wanted a shorter method for doing this you can capture the output of the `aws ec2 create-security-group` command as the variable security_group_id. An example is below:

`test_security_group_id=$(aws ec2 create-security-group --group-name test-$your_name --description "security group for test-$your_name servers" --vpc-id $vpc_id --region $region --output text)`

# Create an EC2 Instance
The command below will:

1. Run (meaning startup) an EC2 Instance.
2. Use the "AMI ID" ami-5189a661 - this AMI ID is an Ubuntu Server 14.04 AMI.
3. Use the Instance Type of t2.micro - this is a less expensive but less powerful EC2 instance type.
4. Make the newly run instance a member of the previously created "test-$yourname" Security Group.
5. Place this instance in the Subnet ID $subnet_id.
6. Associate a Public IP Address - for now - a Public IP address is required for an instance to receive packets from Internet Gateway - we'll explore alternative options for Internet connectivity in other modules.

`aws ec2 run-instances --image-id ami-5189a661 --region $region --instance-type t2.micro --security-group-id $test_security_group_id --subnet-id $subnet_id --associate-public-ip-address --key-name $your_name --output table`

# SSH Into the Test Instance
The last task that we will have in this lab is to log into the test-yourname instance that we have just created. In order to do this, we need the keypair that we have created as well as the Public IP address of the "Test" server that we had just made.

To get the PubliC IP address of the newly created server, locate the Instance ID from the table that was displayed a result of the previous launch - it will look similar to the below:

    --------------------------------------------------------------------------
    |                              RunInstances                              |
    +------------------------------------+-----------------------------------+
    |  OwnerId                           |  055361672320                     |
    |  ReservationId                     |  r-0f490605                       |
    +------------------------------------+-----------------------------------+
    ||                               Instances                              ||
    |+------------------------+---------------------------------------------+|
    ||  AmiLaunchIndex        |  0                                          ||
    ||  Architecture          |  x86_64                                     ||
    ||  ClientToken           |                                             ||
    ||  EbsOptimized          |  False                                      ||
    ||  Hypervisor            |  xen                                        ||
    ||  ImageId               |  ami-5189a661                               ||
    ||  InstanceId            |  i-0441bbf3                                 ||
    ||  InstanceType          |  t2.micro                                   ||
    ||  KeyName               |  cjohnson                                   ||

InstanceId is about the 14th line down. Copy that value and replace run as part of the following command:

`test_instance_public_ip=$(aws ec2 describe-instances --instance-id REPLACE--region $region --output text --query Reservations[*].Instances[*].PublicIpAddress)`

then, ssh into your new instance!

`ssh -i ~/$your_name.pem ubuntu@$test_instance_public_ip`

# Delete Your Test Instance
Lastly - we'll no longer need the Test instance or Security Group that we had created. Let's go ahead and delete them:

`aws ec2 terminate-instances --instance-id REPLACE --region us-west-2`

`aws ec2 delete-security-group --group-id $test_security_group_id --region $region`

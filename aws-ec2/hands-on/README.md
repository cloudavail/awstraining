# Overview:

Contained with the hands-on labs for the aws-ec2 module are the following labs:

## Infrastructure with Gateway and www Servers
A diagram of the infrastructure is below:
[![Simple Infrastructure Buildout](assets/aws-ec2-project-infrastructure-diagram.png)](#features)

If you wish to buildout the infrasture, you'll need to walk through the following guides:

1. security_groups-create
2. ec2-create-instances
3. ec2-login-through-gateway

## Automated www Server Build using User-Data

If you wish to complete the automated build of a www Server, you'll need to walk through the following guides:

1. security_groups-create
2. ec2-create-instances (note: you can skip creation of "www" node if desired)
3. ec2-user-data

## EBS Volume Performance Test

Walking through the performance of an EBS volume can take quite some time - it is suggested that you pre-warm the EBS volume by writing to every block on an EBS volume before performance testing (see: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-prewarm.html). The lab is interesting but may require a fair amount of time an effort. You'll need to walk through the following guides:

1. security_groups-create (note: you can skip creation of "www" security groups if desired)
2. ec2-create-instances (note: you can skip creation of "www" node if desired)
3. ebs-performance-test

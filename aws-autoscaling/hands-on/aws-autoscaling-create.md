# Set Required Variables

`region="us-west-2"`

`vpc_id="vpc-f38d3796"`

`subnets="subnet-5a84342d subnet-7a94061f subnet-7930e720"`

`subnets_csv=subnet-5a84342d,subnet-7a94061f,subnet-7930e720`

`your_name="cjohnson"`

`key_name="cjohnson"`

# Create Security Groups

## Create a www ELB Security Group
`wwwelb_security_group_id=$(aws ec2 create-security-group --group-name wwwelb-$your_name --description "security group for wwwelb-$your_name" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the www ELB security group is: $wwwelb_security_group_id."`

## Authorize HTTP Ingress for the www ELB Security Group

`aws ec2 authorize-security-group-ingress --group-id $wwwelb_security_group_id --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $region`

and confirm the result:

`aws ec2 describe-security-groups --group-id $wwwelb_security_group_id --region $region --output table`

## Create a www Auto Scaling Group Security Group

`www_security_group_id=$(aws ec2 create-security-group --group-name www-$your_name --description "security group for www-$your_name" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the www security group is: $www_security_group_id."`

## Authorize HTTP and SSH Ingress for the www Security Group

`aws ec2 authorize-security-group-ingress --group-id $www_security_group_id --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $region`

`aws ec2 authorize-security-group-ingress --group-id $www_security_group_id --protocol tcp --port 80 --source-group $wwwelb_security_group_id --region $region`

and confirm the result:

`aws ec2 describe-security-groups --group-id $wwwelb_security_group_id --region $region --output table`

# Create an ELB

`wwwelb_id=$(aws elb create-load-balancer --load-balancer-name www-$your_name --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --security-groups $wwwelb_security_group_id --subnets $subnets --region $region)`

# Create Auto Scaling Group

## Create Launch Config (On Demand)

Note: if you want to experiment with spot pricing - use the launch configuration under "Create Launch Config (Spot Price)"

`aws autoscaling create-launch-configuration --launch-configuration-name www-$your_name --image-id ami-5189a661 --instance-type t2.micro --key-name $key_name --security-groups $www_security_group_id --associate-public-ip-address --user-data file://simple-web-server.sh --region $region`

## Create Launch Config (Spot Price)

Want to save some money? Use "Spot" Pricing. Note: Spot Pricing can take a while to fulfill and is not predictable - my suggestion if you choose spot pricing - ask a neighbor if you can pair with them while you await the spot bid to be fulfilled. 

`spot_price_max="0.20"`

`aws autoscaling create-launch-configuration --spot-price $spot_price_max --launch-configuration-name www-$your_name --image-id ami-5189a661 --instance-type m3.medium --key-name $key_name --security-groups $www_security_group_id --associate-public-ip-address --user-data file://simple-web-server.sh --region $region`

## Create Auto Scaling Group

`aws autoscaling create-auto-scaling-group --auto-scaling-group-name www-$your_name --launch-configuration-name www-$your_name --min-size 1 --max-size 1 --desired-capacity 1 --load-balancer-names www-$your_name --vpc-zone-identifier $subnets_csv --tags Key=Name,Value=www-$your_name,PropagateAtLaunch=true --region $region`
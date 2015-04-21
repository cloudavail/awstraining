# Set Required Variables

`region="us-west-2"`

`your_name="cjohnson"`

# Create Scaling Policies
Scaling policies are triggered by CloudWatch alarms.

## Create a Scale Out Policy

`www_scale_out_arn=$(aws autoscaling put-scaling-policy --policy-name www-$your_name-scaleout --auto-scaling-group-name www-$your_name --scaling-adjustment 1 --adjustment-type ChangeInCapacity --cooldown 120 --region $region --output text)`

Confirm that the scale out policy has been created:

echo "The scale out policy ARN is: $www_scale_out_arn"

## Create a Scale In Policy

`www_scale_in_arn=$(aws autoscaling put-scaling-policy --policy-name www-$your_name-scalein --auto-scaling-group-name www-$your_name --scaling-adjustment -1 --adjustment-type ChangeInCapacity --cooldown 120 --region $region --output text)`

Confirm that the scale in policy has been created:

echo "The scale in policy ARN is: $www_scale_out_arn"

# Create an Alarm

## Create a "Scale Out" Alarm
In summary: the alarm below will trigger the alarm-action "www-yourname-scaleout" when average CPU Utilization is greater than or equal to 50% for two consecutive 60 second periods.

`aws cloudwatch put-metric-alarm --alarm-name www-$your_name-CPU-High --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 60 --comparison-operator GreaterThanOrEqualToThreshold --dimensions "Name=AutoScalingGroupName,Value=www-$your_name" --evaluation-periods 2 --alarm-actions $www_scale_out_arn --region $region`

## Create a "Scale In" Alarm
In summary: the alarm below will trigger the alarm-action "www-yourname-scalein" when average CPU Utilization is less than or equal to 10% for two consecutive 60 second periods. Note: the lower threshold has proven tricky to tune correctly for labs as a completely idle systems are - completely idle.

`aws cloudwatch put-metric-alarm --alarm-name www-$your_name-CPU-Low --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 60 --threshold 10 --comparison-operator LessThanOrEqualToThreshold --dimensions "Name=AutoScalingGroupName,Value=www-$your_name" --evaluation-periods 2 --alarm-actions $www_scale_in_arn --region $region`

# Do Auto Scaling:

## Create Load on the First EC2 System

1. Login to the first EC2 instance and install the stress program by running `sudo apt-get -y install stress`
2. Run the stress program to generate load using the following command: `stress --cpu 1 --timeout 10m`

## Take a Break to Investigate the AWS Console
Auto Scaling may be best understood throught the visualization within the AWS Console. Here is what I'd suggest:

1. Go to the CloudWatch service within the AWS Console.
2. Click on "Alarms" from the left-hand navigation - locate your alarm - your alarm will be in "ALARM" state soon
3. If you click the "History" tab you can see the events that have occured as a result of Alarm State Changes..

## If Your Auto Scaling Group has Scaled Up:

1. Remember that the first system will stop running `stress` in about 10 minutes. The "processor intensive job" has completed, the CloudWatch metrics will drop below the point requiring a scale-in action and the group's size will be reduced by one.

# Reference:

- http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/policy_creating.html#policy-creating-aws-cli

# Set Required Variables

`region="us-west-2"`

`your_name="cjohnson"`

# Change Size of www Auto Scaling Group

## Scale Up to 3 Instances

`aws autoscaling update-auto-scaling-group --auto-scaling-group-name www-$your_name --min-size 1 --max-size 3 --desired-capacity 3 --region $region`

## Confirm that the www ELB has 3 Instances

`aws elb describe-instance-health --load-balancer-name www-$your_name --region us-west-2 --output table`

## Scale Down to 1 Instances

`aws autoscaling update-auto-scaling-group --auto-scaling-group-name www-$your_name --min-size 1 --max-size 3 --desired-capacity 3 --region $region`

## Confirm that the www ELB has 1 Instance

`aws elb describe-instance-health --load-balancer-name www-$your_name --region us-west-2 --output table`

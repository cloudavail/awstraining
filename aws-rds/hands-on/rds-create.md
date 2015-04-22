# Create RDS Database

## Set Required Variables:

`region="us-west-2"`

`vpc_id="vpc-f38d3796"`

`your_name="cjohnson"`

## Create RDS Security Group

`rds_security_group_id=$(aws ec2 create-security-group --group-name api-db-$your_name --description "security group for api-db-$your_name database" --vpc-id $vpc_id --region $region --output text)`

and confirm the result:

`echo "The Security Group ID for the RDS security group is: $rds_security_group_id."`

## Authorize MySQL Ingress for the api-db Security Group

`aws ec2 authorize-security-group-ingress --group-id $rds_security_group_id --protocol tcp --port 3306 --source-group $gateway_security_group_id --region $region`

and confirm the result:

`aws ec2 describe-security-groups --group-id $rds_security_group_id --region $region --output table`

## Create the RDS Database

`aws rds create-db-instance --db-name $your_name --db-instance-identifier api-db-$your_name --allocated-storage 20 --db-instance-class db.t2.micro --engine mysql --master-username $your_name --master-user-password $your_name --vpc-security-group-ids $rds_security_group_id --db-subnet-group-name default --region $region`

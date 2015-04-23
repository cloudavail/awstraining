# Set Required Variables:

`region="us-west-2"`

`your_name="cjohnson"`

# Create RDS Snapshot

`aws rds create-db-snapshot --db-instance-identifier api-$your_name --db-snapshot-identifier $your_name-$date --region $region`

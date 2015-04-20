# Before you Begin:

set variables for future use:

`region="us-west-2"`

`availability_zone="us-west-2a"`

and confirm the EBS Volume ID is stored in the $ebs_volume_id variable:

`echo "The volume ID of the new EBS Volume is: $ebs_volume_id."`

# Snapshot the EBS Volume

snapshot_id=$(aws ec2 create-snapshot --volume-id $ebs_volume_id --region $region --output text --query SnapshotId)

and confirm that the Snapshot ID has been captured as a variable:

`echo "The snapshot ID of the newly created snapshot is is: $snapshot_id."`

# Restore the EBS Volume

`ebs_volume_id_restored=$(aws ec2 create-volume --snapshot-id $snapshot_id --size 60 --iops 1800 --volume-type io1 --availability-zone $availability_zone --region $region --output text --query VolumeId)`

# And confirm new EBS Volume Attributes

The new volume should have the following attributes:

1. IOPS: 1800
2. Size: 60
3. VolumeType: io1

`aws ec2 describe-volumes --volume-id $ebs_volume_id_restored --region $region --output table`

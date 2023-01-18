# Overview

The CloudFormation file `aws_route53_with_failover_primary_secondary_healthchecks.yaml` in this directory will create an Application Load Balancer that utilizes a redirect.

# Validate Templates

```shell
aws cloudformation validate-template --template-body file://aws_route53_with_failover_primary_secondary_healthchecks.yaml
```

# Create an aws-route53-with-primary-secondary-healthchecks Stack

```shell
aws cloudformation create-stack --stack-name aws-route53-with-primary-secondary-healthchecks --template-body file://aws_route53_with_failover_primary_secondary_healthchecks.yaml
```

# Update an aws-route53-with-primary-secondary-healthchecks Stack

```shell
aws cloudformation update-stack --stack-name aws-route53-with-primary-secondary-healthchecks --template-body file://aws_route53_with_failover_primary_secondary_healthchecks.yaml
```

# Delete aws-route53-with-primary-secondary-healthchecks Stack

```shell
aws cloudformation delete-stack --stack-name aws-route53-with-primary-secondary-healthchecks
```

# Note

# Overview

The CloudFormation file `aws_route53_with_failover.yaml` in this directory will create an Application Load Balancer that utilizes a redirect.

# Validate Templates

```shell
aws cloudformation validate-template --template-body file://aws_route53_with_failover.yaml
```

# Create an aws-route53-with-failover Stack

```shell
aws cloudformation create-stack --stack-name aws-route53-with-failover --template-body file://aws_route53_with_failover.yaml
```

# Update an aws-route53-with-failover Stack

```shell
aws cloudformation update-stack --stack-name aws-route53-with-failover --template-body file://aws_route53_with_failover.yaml
```

# Delete aws-route53-with-failover Stack

```shell
aws cloudformation delete-stack --stack-name aws-route53-with-failover
```

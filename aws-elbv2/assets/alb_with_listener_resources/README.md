# Note

# Overview

The CloudFormation file `alb_with_listener_resources.yaml` in this directory will create an Application Load Balancer that utilizes a redirect.

# Validate Templates

```shell
aws cloudformation validate-template --template-body file://alb_with_listener_resources.yaml
```

# Create an alb-with-listener-resources Stack

```shell
aws cloudformation create-stack --stack-name alb-with-listener-resources --template-body file://alb_with_listener_resources.yaml
```

# Update an alb-with-listener-resources Stack

```shell
aws cloudformation update-stack --stack-name alb-with-listener-resources --template-body file://alb_with_listener_resources.yaml
```


# Delete alb-with-listener-resources Stack

```shell
aws cloudformation delete-stack --stack-name alb-with-listener-resources
```

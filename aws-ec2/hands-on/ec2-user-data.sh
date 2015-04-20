#!/bin/bash -
apt-get -y install apache2

ami_id=$(curl --silent http://169.254.169.254/latest/meta-data/ami-id)
instance_id=$(curl --silent http://169.254.169.254/latest/meta-data/instance-id)
instance_type=$(curl --silent http://169.254.169.254/latest/meta-data/instance-type)
local_ip=$(curl --silent http://169.254.169.254/latest/meta-data/local-ipv4)
public_ip=$(curl --silent http://169.254.169.254/latest/meta-data/public-ipv4)

cat > /var/www/html/index.html <<EOF
<html>
<head>
</head>
<body>
<h1>Server Information</h1>
<ul>
  <li>AMI: $ami_id</li>
  <li>Instance ID: $instance_id</li>
  <li>Instance Type: $instance_type</li>
  <li>Local IP: $local_ip</li>
  <li>Public IP: $public_ip</li>
</ul>
</body>
</html>
EOF

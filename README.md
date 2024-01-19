# terraform-aws-ec2-monitoring
## Default cloudwatch ec2-role
Role : EC2-CloudWatch-Role
## New EC2
Create an EC2 Instance, Attach the role  EC2-CloudWatch-Role and in user data section add the following command ton install and configure cloudwatch agent :

````
#!/bin/bash
wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip
unzip AmazonCloudWatchAgent.zip
sudo ./install.sh
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:/alarm/AWS-CWAgentLinuxConfig -s
```
## Check if EC2 Instance has CWAgent Installed or not:
````
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status
```
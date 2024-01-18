terraform apply --auto-approve && sed instance_id=tfstate_instnaceid && sleep 60
&& aws ec2 describe-instance-status --instance-id $instance_id | jq status == true &&

aws ssm send-command \

    --instance-ids $instance_id  \

    --document-name "AWS-RunShellScript" \

    --comment "IP config" \

    --parameters "commands=systemctl ansible --version" >>
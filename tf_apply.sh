terraform init
#terraform plan
terraform fmt
echo "----------------********************************----------------"
echo "Deleting Old TF_State.JSON files...!"
rm -rf terraform.json
sleep 5
echo "----------------********************************----------------"

#Initiallizing the terraform apply
echo "Initiallizing Terraform Apply...!"
terraform apply --auto-approve

sleep 30

#Copying TF.state file to Json
cp terraform.tfstate terraform.json
output=$(jq -r '.resources[].instances[].attributes.id | select(test("^i-"))' terraform.json)
status=$(aws ec2 describe-instances --instance-ids "$output" --query 'Reservations[].Instances[].State.Name' --output text)

#echo "Initiallizing Instance Status...!"
echo "Instance ID: $output"
echo "Instance Status: $status"
sleep 60

if [ "$status" = "running" ]; then
    ansible_version=$(
        aws ssm send-command \
            --instance-ids "$output" \
            --document-name "AWS-RunShellScript" \
            --comment "IP config" \
            --parameters "commands=ansible --version"
    )
    echo "Ansible version: $ansible_version"
fi

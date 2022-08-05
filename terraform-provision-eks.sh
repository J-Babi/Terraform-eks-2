#!/bin//bash
terraform init
#terraform update
terraform validate
terraform plan
terraform apply --auto-approve
aws eks update-kubeconfig --name eks-dev --region us-east-2
cat /var/lib/jenkins/.kube/config

# output "hello_base_url" {
#   value = "${aws_apigatewayv2_stage.Dev.invoke_url}/echo"
# }

# Re-run terraform apply then curl to test integration.

# terraform apply curl https://<your-gw-id>.execute-api.us-east-2.amazonaws.com/dev/echo

#awk 'NR==20,NR==43 {print $0}' outputs > ~/.kube/config

#scp username@remote:/file/to/send /where/to/put
#scp ubuntu@IP:/var/lib/jenkins/.kube/config ~/.kube/ # requires remote server authentication

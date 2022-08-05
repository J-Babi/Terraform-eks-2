# 11) integration.tf    ###
# Could be provision with the other resources if applied as amodule.

resource "aws_security_group" "vpc_api_gw_link" {
  name   = "vpc-api_gw_link"
  vpc_id = aws_vpc.Dev.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# b) Create API-GW
resource "aws_apigatewayv2_vpc_link" "eks" {
  name               = "eks"
  security_group_ids = [aws_security_group.vpc_api_gw_link.id]
  subnet_ids = [
    aws_subnet.private-us-east-2a.id,
    aws_subnet.private-us-east-2b.id
  ]
}

# c) Integrate API-GW to eks cluster
resource "aws_apigatewayv2_integration" "eks" {
  api_id = aws_apigatewayv2_api.Dev.id

  integration_uri    = "get api-gw url from console & insert here"
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.eks.id
}

resource "aws_apigatewayv2_route" "get_echo" {
  api_id = aws_apigatewayv2_api.Dev.id

  route_key = "GET /echo"
  target    = "integrations/${aws_apigatewayv2_integration.eks.id}"
}

output "hello_base_url" {
  value = "${aws_apigatewayv2_stage.Dev.invoke_url}/echo"
}

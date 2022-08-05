# 10) api-gateway.tf ###

resource "aws_apigatewayv2_api" "Dev" {
  name          = "Dev"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "Dev" {
  api_id = aws_apigatewayv2_api.Dev.id

  name        = "Dev"
  auto_deploy = true
}

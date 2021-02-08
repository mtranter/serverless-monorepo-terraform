locals {
  source_code_hash = coalesce(var.source_code_hash, filebase64sha256(var.filename))
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = var.name
  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.function.function_name}"
  retention_in_days = 14
}


data "aws_iam_policy_document" "can_log" {
  statement {
    sid       = "${var.name}CanLog"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      aws_cloudwatch_log_group.lambda_log_group.arn
    ]
  }
}

resource "aws_iam_role_policy" "can_log" {
  policy = data.aws_iam_policy_document.can_log.json
  role   = aws_iam_role.iam_for_lambda.id
}

resource "aws_lambda_function" "function" {
  function_name                  = var.name
  handler                        = var.handler
  role                           = aws_iam_role.iam_for_lambda.name
  runtime                        = "nodejs12.x"
  filename                       = var.filename
  source_code_hash               = local.source_code_hash
  timout                         = var.timeout
  reserved_concurrent_executions = var.concurrency
  publish                        = var.publish
  environment {
    variables = var.env_vars
  }
  tags                           = var.tags
}

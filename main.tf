locals {
  language_default = {
    nodejs = {
      runtime            = ["nodejs20.x", "nodejs18.x", "nodejs16.x"]
      source_code_folder = "./source-code/nodejs"
      handler            = "index.handler"
    },
    python = {
      runtime            = ["python3.12", "python3.11", "python3.10", "python3.9", "python3.8"]
      source_code_folder = "./source-code/python"
      handler            = "index.handler"
    },
    java = {
      runtime            = ["java17", "java11", "java8"]
      source_code_folder = "./source-code/java"
      handler            = "example.Handler::handleRequest"
    }
  }
}

locals {
  lambda_language    = local.language_default["${var.lambda_language}"]
  lambda_runtime     = contains(local.lambda_language.runtime, var.lambda_runtime) ? var.lambda_runtime : local.lambda_language.runtime[0]
  source_code_folder = (var.source_code_folder == null) ? local.lambda_language.source_code_folder : var.source_code_folder
  lambda_handler     = (var.lambda_handler == null) ? local.lambda_language.handler : var.lambda_handler
  lambda_description = "This Scheduled Job written in ${local.lambda_runtime} and running on a schedule ${var.schedule}"
}

data "archive_file" "lambda_package" {
  type        = "zip"
  source_dir  = local.source_code_folder
  output_path = "${var.lambda_name}-Lambda.zip"
}

resource "aws_lambda_function" "batchjob_lambda_function" {
  function_name    = var.lambda_name
  description      = local.lambda_description
  filename         = "${var.lambda_name}-Lambda.zip"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  role             = var.lambda_execution_role
  runtime          = local.lambda_runtime
  handler          = local.lambda_handler
  timeout          = var.lambda_timeout

  vpc_config {
    subnet_ids         = (var.vpc_subnets == null) ? [] : var.vpc_subnets
    security_group_ids = (var.vpc_security_groups == null) ? [] : var.vpc_security_groups
  }

  layers = var.lambda_layers

  environment {
    variables = var.lambda_env_vars
  }

  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "batchjob_event_rule" {
  name                = "run-lambda-${var.lambda_name}"
  description         = "Schedule to run lambda in every 5 minutes"
  schedule_expression = var.schedule
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "lambda_function_target_batchjob" {
  target_id = "lambda-function-target-${var.lambda_name}"
  rule      = aws_cloudwatch_event_rule.batchjob_event_rule.name
  arn       = aws_lambda_function.batchjob_lambda_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_batchjob" {
  statement_id  = "AllowExecutionFromCloudWatch-${var.lambda_name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.batchjob_lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.batchjob_event_rule.arn
}

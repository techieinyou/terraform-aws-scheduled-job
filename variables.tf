variable "vpc_subnets" {
  type        = list(string)
  default     = null
  description = "One or more Subnets, if you like to create the Scheduled Job inside a VPC"
}

variable "vpc_security_groups" {
  type        = list(string)
  default     = null
  description = "One or more Security Groups, if you like to create the Scheduled Job inside a VPC"
}

variable "lambda_execution_role" {
  type        = string
  description = "You should have an IAM Role ready to execute this module.  Provide the ARN for a role which has required permission to execute the scheduled job lambda."
}

variable "lambda_name" {
  type        = string
  default     = "scheduled-job"
  description = "Name of the Lambda for the scheduled job."
}

variable "lambda_language" {
  type        = string
  default     = "nodejs"
  description = "Language of the code written for scheduled job.  All supported langauges are listed in README."
  validation {
    condition     = contains(["nodejs", "python"], var.lambda_language)
    error_message = "Unsupported Language <${var.lambda_language}>. Supported values are <nodejs, python>"
  }
}

variable "lambda_runtime" {
  type        = string
  default     = "nodejs20.x"
  description = "Runtime identifier based on the language and version the scheduled-job code is written. All supported runtimes are listed in README."
  validation {
    condition     = contains(["nodejs20.x", "nodejs18.x", "nodejs16.x", "python3.12", "python3.11", "python3.10", "python3.9", "python3.8", null], var.lambda_runtime)
    error_message = "Unsupported runtime <${var.lambda_runtime}>"
  }
}

variable "source_code_folder" {
  type        = string
  default     = null
  description = "Path to Folder where the source code for scheduled job."
}

variable "lambda_handler" {
  type        = string
  default     = null
  description = "Entry-point function name to start executing the lambda. Default values are Nodejs: index.handler,  Python: lambda_function.lambda_handler."
}

variable "lambda_timeout" {
  type        = number
  default     = 180
  description = "Execution Timeout for the lambda."
}

variable "lambda_layers" {
  type        = list(string)
  default     = null
  description = "List of Lambda Layers to be used by the scheduled-job lambda."
}

variable "schedule" {
  type        = string
  default     = "rate(5 minutes)"
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). For more information, refer to the AWS documentation Schedule Expressions for Rules."
}

variable "lambda_env_vars" {
  type        = map(any)
  default     = null
  description = "List of Environment variables referred by Lambda."
}

variable "tags" {
  type        = map(any)
  description = "List of Tags for the Lambda."
  default = {
    "created_by" : "Terraform-Module: TechieInYou/scheduled-job/aws"
  }
}

variable "lambda_name" {
  type    = string
  default = "scheduled-job"
}

variable "lambda_source_file" {
  type    = string
  default = null
}

variable "lambda_handler" {
  type    = string
  default = null
}

variable "lambda_language" {
  type    = string
  default = "nodejs"
  validation {
    condition     = contains(["nodejs", "python", "java"], var.lambda_language)
    error_message = "Unsupported Language <${var.lambda_language}>"
  }
}

variable "lambda_runtime" {
  type    = string
  default = null
}

variable "lambda_timeout" {
  type    = number
  default = 180
}

variable "lambda_layers" {
  type    = list(string)
  default = null
}

variable "schedule" {
  type    = string
  default = "rate(5 minutes)"
}

variable "lambda_env_vars" {
  type = map(any)
  default = null
}

variable "lambda_execution_role" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
    "created_by" : "Terraform-Module"
  }
}

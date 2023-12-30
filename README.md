# terraform-aws-scheduled-job
This Terraform module will package your Nodejs/Python code and upload to Lambda, and schedule for running on specified intervals.  

This module is published in Terraform as **TechieInYou/scheduled-job/aws**.   


# Supported Languages
This module currently supports NodeJS and Python.  Allowed runtimes are listed below. 

## Node.js

This module supports the following Node.js runtimes.

| Version     | Identifier |	
|-------------|----------- |
| Node.js 20  | nodejs20.x |
| Node.js 18  | nodejs18.x |
| Node.js 16  | nodejs16.x |

See more info on https://docs.aws.amazon.com/lambda/latest/dg/lambda-nodejs.html

## Python

This module supports the following Python runtimes.

| Version       | Identifier |	
|---------------|----------- |
| Python 3.12   | python3.12 |
| Python 3.11   | python3.11 |
| Python 3.10   | python3.10 |
| Python 3.9    | python3.9  |
| Python 3.8    | python3.8  |

See more info on https://docs.aws.amazon.com/lambda/latest/dg/lambda-python.html


# Mandatory Input Variables

### lambda_execution_role
You should have an IAM Role ready to execute this module.  Provide the ARN for a role which has required permission to execute the scheduled job lambda.


# Optional Input Variables

### lambda_name
Name of the Lambda for the scheduled job. Default value is **scheduled-job**

### lambda_source_file
File name where the code contains for scheduled job

### lambda_handler
Entry-point function name to start executing the lambda. Below are the default values
    - Nodejs - index.handler
    - Python - lambda_function.lambda_handler


### lambda_language
Language of the code written for scheduled job.  All supported languages are listed above

### lambda_runtime
Runtime identifier based on the language and version the scheduled-job code is written. All supported runtimes are listed above

### lambda_timeout
Execution Timeout for the lambda. Default is 180.

### lambda_layers
List of Lambda Layers to be used by the scheduled-job lambda.

### schedule
The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). For more information, refer to the AWS documentation Schedule Expressions for Rules.

### lambda_env_vars
List of Environment variables referred by Lambda.

### tags
List of Tags for the Lambda.


# Output 
This module will print below values after successfull run

    - lambda_arn: ARN of the lambda created by this module
    - iam_role_arn: ARN of the IAM role provided by user
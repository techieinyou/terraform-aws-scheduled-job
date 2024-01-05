# Scheduled Job in AWS
This Terraform module will package your Nodejs/Python code and upload to Lambda, and schedule for running on specified intervals.  

This module is published in Terraform as [**TechieInYou/scheduled-job/aws**](https://registry.terraform.io/modules/techieinyou/scheduled-job/aws/latest).  Similar module for Azure is also published as [**TechieInYou/scheduled-job/azure**](https://registry.terraform.io/modules/techieinyou/scheduled-job/azure/latest) 

# Supported Languages
This module currently supports NodeJS and Python.  Allowed runtime versions are listed below. 

## Node.js

This module supports the following Node.js runtimes.  See more info in [AWS Documentation](https://docs.aws.amazon.com/lambda/latest/dg/lambda-nodejs.html).

| Version     | Identifier |	
|-------------|----------- |
| Node.js 20  | nodejs20.x |
| Node.js 18  | nodejs18.x |
| Node.js 16  | nodejs16.x |

## Python

This module supports the following Python runtimes.  See more info in [AWs Documentation](https://docs.aws.amazon.com/lambda/latest/dg/lambda-python.html)

| Version       | Identifier |	
|---------------|----------- |
| Python 3.12   | python3.12 |
| Python 3.11   | python3.11 |
| Python 3.10   | python3.10 |
| Python 3.9    | python3.9  |
| Python 3.8    | python3.8  |

# Source Code for the Scheduled Job
You can keep the Nodejs/Python source code in a folder and assign below varaibles

    - source_code_folder:  path to your source code 
    - lambda_handler: handler in the format <file-name>.<entry-point>  eg. index.handler

# Scheduling the Job
You can schedule your job with a timer trigger by assigning **schedule** variable with either cron or rate expression.  For example, `cron(0 20 * * ? *)` or `rate(5 minutes)`.
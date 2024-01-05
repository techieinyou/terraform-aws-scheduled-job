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

## Source Code for scheduled job
You can keep the Nodejs/Python source code in a folder and assign below varaibles

    - source_code_folder:  path to your source code 
    - lambda_handler: handler in the format <file-name>.<entry-point>  eg. index.handler


## Scheduling the Job
You can schedule your job with a timer trigger by assigning **schedule** variable with either cron or rate expression.  For example, cron(0 20 * * ? *) or rate(5 minutes).
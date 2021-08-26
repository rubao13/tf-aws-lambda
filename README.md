## Overview 
configuration management template in Terraform which will:

## Tasks
1. Create an AWS Lambda function in AWS region
2. Lambda function should be automatically triggered by schedule (each day at 02:00)
3. Lambda function checks all AWS Application Load Balancers and find the ones which have listener on 80 port
4. For each such ALB lambda function will create default rule: "redirect to https"

### Running the Terraform

*After edit credentials in variables.tf with access_key and secret*

`terraform init`

`terraform plan`

*search for line: Plan: 7 to add, 0 to change, 0 to destroy.*

`terraform apply`

*Apply complete! Resources: 7 added, 0 changed, 0 destroyed.*

*Outputs:*

*lambda_function_name = "task-7s-lambda-check-lb"*


### Running Lambda function
Access AWS https://console.aws.amazon.com/lambda/home?region=us-east-1#/functions

Locate function `task-7s-lambda-check-lb` and click `Test` > `Configure test event`, after this hit again `Test`

Outputs will be like this to help debug:

  - **Hello from 7s-lb-checker!
  
  - **--------------LOAD-BALANCER----------------------
  
  - **-------------------------------------------------
  
  - **arn:aws:elasticloadbalancing:xxxx:xxxx:loadbalancer/app/xxxx/xxxx	xxxx-xxxx.us-xxxx-1.elb.amazonaws.com
  
  - **--------------describe_listeners----------------------
  
  - **{'Listeners': [{'ListenerArn': 'arn:aws:elasticloadbalancing:us-xxx-1:xxxxx:listener/app/xxxxx/xxxx/xxxx', ...
  
    - **-------------------------------------------------
    
  - **80
  
  - **--------------------- rule -------------------
  
  - **{'Rules': [{'RuleArn': 'arn:aws:elasticloadbalancing:us-xxxxxx-1:xxxxxx:listener-rule/app/xxxxx/xxxxxx/xxxxxx/xxxxx', ...
  
  - **--------------------- create rule -------------------
    
  - **-------------------------------------------------
  
  - **Task completed.
  

## That's all Folks! 

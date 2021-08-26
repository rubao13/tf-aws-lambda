provider "aws" {

  #edit credentials in variables.tf access_key and secret

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
  
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
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

resource "aws_iam_policy" "iam_for_elb" {
  name = "iam_for_elb"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_elb" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam_for_elb.arn
}

resource "aws_lambda_function" "task-7s-lambda-check-lb"{
  role          = aws_iam_role.iam_for_lambda.arn
  function_name = "task-7s-lambda-check-lb"
  description   = "task lambda function LB checker"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  timeout       = "420"
  filename = "python/index.py.zip"
  
  depends_on = [
    aws_iam_role_policy_attachment.lambda_elb
  ]
  

}

resource "aws_cloudwatch_event_rule" "every_day_2am" {
  name                = "every_day_2am"
  description         = "Fires every day 2am"
  schedule_expression = "cron(0 2 * * ? *)"
}

resource "aws_cloudwatch_event_target" "check_every_day_2am" {
  rule      = "${aws_cloudwatch_event_rule.every_day_2am.name}"
  target_id = "lambda"
  arn       = "${aws_lambda_function.task-7s-lambda-check-lb.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "task-7s-lambda-check-lb"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.every_day_2am.arn}"
}
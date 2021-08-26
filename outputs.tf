# Lambda Function
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.arn, [""]), 0)
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.invoke_arn, [""]), 0)
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.function_name, [""]), 0)
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.qualified_arn, [""]), 0)
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.version, [""]), 0)
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.last_modified, [""]), 0)
}

output "lambda_function_kms_key_arn" {
  description = "The ARN for the KMS encryption key of Lambda Function"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.kms_key_arn, [""]), 0)
}

output "lambda_function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.source_code_hash, [""]), 0)
}

output "lambda_function_source_code_size" {
  description = "The size in bytes of the function .zip file"
  value       = element(concat(aws_lambda_function.task-7s-lambda-check-lb.*.source_code_size, [""]), 0)
}

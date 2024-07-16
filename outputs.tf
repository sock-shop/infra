# S3
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the TF state s3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_state.name
  description = "The name of DynamoDB table for the TF state s3 bucket"
}


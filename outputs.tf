output "dynamodb_table_id" {
  value       = aws_dynamodb_table.lock_table.id
  description = "The ID of the DynamoDB table used for remote Terraform state locking."
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.lock_table.arn
  description = "The ARN of the DynamoDB table used for remote Terraform state locking."
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.bucket.id
  description = "The name of the S3 bucket storing the remote Terraform state."
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket storing the remote Terraform state."
}


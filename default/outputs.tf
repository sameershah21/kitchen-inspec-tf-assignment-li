output "bucket_name" {
  description = "ARN of the bucket created"
  value = aws_s3_bucket.bucket.arn
}

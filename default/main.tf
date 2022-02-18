
locals {
  common_tags = {
    environment            = var.environment
    owner                  = var.owner
    infrastructure_version = var.infrastructure_version
    github_repository_name = var.github_repository_name
  }
  #infra structure tags is combination of common tags, service and function and audit tags. They have been refactored as they will be set individually during the implementaiton workflow by different actors like security officer, developer and devops.
  infra_tags = merge(local.common_tags, {
    service  = var.service
    function = var.function
  }, var.audit_tags)
  topic_name                   = var.topic_name
  email_address_for_subscriber = var.email_address_for_subscriber
}

#creation of bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket-name
  tags   = local.infra_tags

}

# s3 acl to be set to private
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

#create an sns topic which will publish the s3 object creation notification to its subscribers. Also, make sure, that only s3 buckets can publish
resource "aws_sns_topic" "sns_topic" {
  name = local.topic_name

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:${local.topic_name}",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.bucket.arn}"}
        }
    }]
}
POLICY
}

# create a bucket notification for triggering an email when s3 object is created
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  topic {
    topic_arn     = aws_sns_topic.sns_topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}

# create a sns topic sub for triggering an email when s3 object is created
resource "aws_sns_topic_subscription" "sns-topic" {
  topic_arn              = aws_sns_topic.sns_topic.arn
  protocol               = "email"
  endpoint               = local.email_address_for_subscriber
  endpoint_auto_confirms = true
}

#create a key for s3 objection encryption
resource "aws_kms_key" "s3_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_configuration" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


# we can accomplish the same using more modules like following. However, since I want to keep this setup simple (all in one repo), I have declared all the resources in one file.

//module "external_module_references" {
//  source = "git::git@github.com:<git-org-name>/<git-repo-name>.git?ref=v1.0.0"
//}
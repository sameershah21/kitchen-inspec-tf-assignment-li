
locals {
  common_tags = {
    environment            = var.environment
    owner                  = var.owner
    infrastructure_version = var.infrastructure_version
    github_repository_name = var.github_repository_name
  }
  infra_tags = merge(local.common_tags, {
    service  = var.service
    function = var.function
  }, var.audit_tags)
}


resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket-name
  tags = local.infra_tags

}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_sns_topic" "sns_topic" {
  name = "s3-event-notification-topic"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:s3-event-notification-topic",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.bucket.arn}"}
        }
    }]
}
POLICY
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  topic {
    topic_arn     = aws_sns_topic.sns_topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}
resource "aws_sns_topic_subscription" "sns-topic" {
  #provider  = "aws.sns2sqs"
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = "sameeryam21@gmail.com"
}
# can accomplish the same using  more modules over here to control IAM access.

//module "test" {
//  source = "git::git@github.com:sameershah21/tf-modules-security-group.git//modules/?ref=v1.0.0"
//  tags                = local.infra_tags
//}
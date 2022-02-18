# we call the main module with values that we need to pass. This is iterative i.e module can be called several times with different values generating different results. These results can be used comparing with actual results.
module "for_staging_env" {
  source = "../../../staging"
  audit_tags = {
    "Audited" = "True" # Changing this to any other value will make the test case to fail.
  }
  topic_name                   = "s3-event-notification-topic"
  email_address_for_subscriber = "<enter your email address here>"

}

output "bucket_name" {
  description = "Name of the bucket created"
  value       = module.for_staging_env.bucket_name
}
# Similar to above, we can call the module from the production(symlinked folder).
//module "for_production_env" {
//  source = "../../../production"
//  audit_tags = {
//    "Audited" = "True" # Changing this to any other value will make the test case to fail.
//  }
//    topic_name                   = "<another-topic-name>"
//    email_address_for_subscriber = "<another-email>"
//
//}
//
//output "bucket_name" {
//  description = "Name of the bucket created"
//  value = module.for_production_env.bucket_name
//}
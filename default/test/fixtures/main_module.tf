# we call the main module with values that we need to pass. This is iterative i.e module can be called several times with different values generating different results. These results can be used comparing with actual results.
module "call_1" {
  source = "../../../staging"
  audit_tags = {
    "Audit_Date" = "Feb 14 2022" # Changing this to any other value will make the test case to fail.
  }

}

output "bucket_name" {
  description = "ARN of the bucket created"
  value = module.call_1.bucket_name
}

//module "call_2" {
//  source = "../../../staging"
//  audit_tags = {
//    "Audit_Date" = "Mar 14 2022" # will fail the tag test
//  }
//
//}
//
//output "bucket_name_call_2" {
//  description = "ARN of the bucket created"
//  value = module.call_2.bucket_name
//}
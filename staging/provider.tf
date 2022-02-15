terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"

      # using specific version to make sure infra tests don't fail.
    }
  }
  #Use remote state for setting state in real life scenario, however for this assignment, emphasis is on the setup, hence using local state
  //    backend "s3" {
  //    bucket  = "terraform-state-staging-us-west-2"
  //    region  = "us-west-2"
  //    key     = "staging-kitchen-inspec-tf-assignment"
  //    profile = "staging"
  //  }
}

#region based default provider
provider "aws" {
  region  = "us-west-2"
  #profile = "staging"
}

provider "aws" {
  region  = "us-east-1"
  alias   = "us-east-1"
  #profile = "staging"
}


#Use remote state for retrieval of outputs in real life scenario, however for this assignment, emphasis is on the setup, hence using local state
//data "terraform_remote_state" "svc" {
//  backend = "s3"
//
//  config = {
//    bucket  = "terraform-state-staging-us-west-2"
//    region  = "us-west-2"
//    key     = "staging-svc"
//    profile = "staging"
//  }
//}
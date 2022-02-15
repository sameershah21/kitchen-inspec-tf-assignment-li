variable "environment" {
  default = ""
  description = "Environment being deployed"
}

variable "service" {
  default = ""
  description = "Name of the service"
}

variable "function" {
  default = ""
  description = "Name of the function"
}

variable "owner" {
  default = ""
  description = "Name of who owns the project"
}

variable "infrastructure_version" {
  default = ""
  description = "Used in tags to track infrastructure versions"
}

variable "github_repository_name" {
  default = ""
  description = "Github Repository Name"
}

variable "bucket-name" {
  default = ""
  description = "Name of the s3 bucket to be created"
}
variable "audit_tags" {
  default = ""
}
//variable "internal-cidrs" {
//  description = " Internal CIDRs"
//  type        = list(string)
//}
//
//variable "external-cidrs" {
//  description = "External Public IP CIDRs"
//  type        = list(string)
//}
//
//variable "vpc_2" {
//  description = "Secondary VPC"
//  default     = "none"
//}
//
//variable "default-rails-port" {
//  description = "Default rails port"
//  default     = 3000
//}
//
//variable "db_port" {
//  description = "Database Port"
//  default     = 5432
//}
//
//variable "redis_port" {
//  description = "Redis Port"
//  default     = 6379
//}
//
//
//variable "db_port_2" {
//  description = "Another non standard Database Port"
//  default     = 23567
//}




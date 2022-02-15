variable "environment" {
  default     = ""
  description = "Environment being deployed"
}

variable "service" {
  default     = ""
  description = "Name of the service"
}

variable "function" {
  default     = ""
  description = "Name of the function"
}

variable "owner" {
  default     = ""
  description = "Name of who owns the project"
}

variable "infrastructure_version" {
  default     = ""
  description = "Used in tags to track infrastructure versions"
}

variable "github_repository_name" {
  default     = ""
  description = "Github Repository Name"
}

variable "bucket-name" {
  default     = ""
  description = "Name of the s3 bucket to be created"
}
variable "audit_tags" {
  default     = {}
  description = "All the key value pairs for audit tags like audited. audit_date and sign_off_date"
  type        = map(string)
}
variable "topic_name" {
  default     = ""
  description = "Name of the topic to be created"
  type        = string
}
variable "email_address_for_subscriber" {
  default     = ""
  description = "Email address where the s3 notification will be sent"
  type        = string
}


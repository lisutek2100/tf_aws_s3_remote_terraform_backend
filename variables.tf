variable "backend_name" {
  type        = string
  description = "Name of the Terraform backend."
}

variable "bucket_prefix" {
  type        = string
  default     = "terraform-s3-backend-"
  description = "Prefix used for the bucket name."
}

variable "budget_notification_email_address" {
  type        = string
  description = "Email at which budget notifications will be sent."
}

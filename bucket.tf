resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_prefix}${var.backend_name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name    = "Terraform Backend State ${var.backend_name}"
    UseCase = "Terraform Backend State"
  }
}

resource "aws_budgets_budget" "s3_state" {
  name              = "${var.backend_name}-s3-bucket-budget"
  budget_type       = "COST"
  time_unit         = "MONTHLY"
  limit_unit        = "USD"
  time_period_start = "2022-02-02_18:00"

  limit_amount      = "28.0"

  cost_filters = {
    TagKeyValue = "Name$Terraform Backend State ${var.backend_name}"
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.budget_notification_email_address]
  }
}

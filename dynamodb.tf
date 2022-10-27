resource "aws_dynamodb_table" "lock_table" {
  name         = "terraform-backend-lock-${lower(var.backend_name)}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name    = "Terraform Backend Lock ${var.backend_name}"
    UseCase = "Terraform Backend Lock"
  }

  lifecycle {
    ignore_changes = [ttl]
  }
}

resource "aws_budgets_budget" "dynamodb_lock_table" {
  name              = "${var.backend_name}-dynamodb-locktable-budget"
  budget_type       = "COST"
  limit_amount      = "45.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2022-02-02_18:00"

  cost_filters = {
    TagKeyValue = "Name$Terraform Backend Lock ${var.backend_name}"
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.budget_notification_email_address]
  }
}

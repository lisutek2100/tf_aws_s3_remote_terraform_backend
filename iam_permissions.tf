resource "aws_iam_policy" "backend_admin" {
  name        = "TerraformBackend-${title(var.backend_name)}-FullAccess"
  path        = "/"
  description = "Policy that provides read/write access on the S3 backend ${var.backend_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "${aws_s3_bucket.bucket.arn}/*"
    },
        {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "${aws_s3_bucket.bucket.arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "${aws_dynamodb_table.lock_table.arn}"
    }
  ]
}
EOF
}

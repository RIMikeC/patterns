# Create a queue to be used for message collection

# Encryption is turned on by default (obvs)

data "aws_caller_identity" "current" {}

resource "aws_kms_key" "input" {
  description = "Inpout queue key"
  tags        = "${merge(var.tags, map("Name", format("%s_input_%s", var.entity, var.environment)))}"
}

resource "aws_kms_alias" "queue_input" {
  name          = "alias/${var.entity}_input_kms_key_${var.environment}"
  target_key_id = "${aws_kms_key.input.id}"
}

# messages are invisible for a minute, but retained for 48 hours
resource "aws_sqs_queue" "input" {
  name = "${var.entity}_input_${var.environment}"

  kms_master_key_id                 = "${aws_kms_key.input.id}"
  kms_data_key_reuse_period_seconds = 86400
  visibility_timeout_seconds        = 60

  message_retention_seconds = 172800
  max_message_size          = 262144
  delay_seconds             = 0
  fifo_queue                = false

  tags           = "${merge(var.tags, map("Name", format("%s_input_%s", var.entity, var.environment)))}"
  redrive_policy = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dlq.arn}\",\"maxReceiveCount\":2}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "AllowPutObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "sqs:*",
            "Resource": "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.entity}_input_${var.environment}",
            "Condition": {
                "StringEquals": {
                    "aws:PrincipalOrgID": ["${var.organisation}"]
                }
            }
        }
    ]
}
EOF
}

# messages are invisible for a minute, but retained for 48 hours
resource "aws_sqs_queue" "dlq" {
  name = "${var.entity}_dlq_${var.environment}"

  kms_master_key_id                 = "${aws_kms_key.input.id}"
  kms_data_key_reuse_period_seconds = 86400
  visibility_timeout_seconds        = 60

  message_retention_seconds = 172800
  max_message_size          = 262144
  delay_seconds             = 0
  fifo_queue                = false

  tags = "${merge(var.tags, map("Name", format("%s_dlq_%s", var.entity, var.environment)))}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "AllowPutObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "sqs:*",
            "Resource": "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.entity}_cdc_in_${var.environment}",
            "Condition": {
                "StringEquals": {
                    "aws:PrincipalOrgID": ["${var.organisation}"]
                }
            }
        }
    ]
}
EOF
}

#output "key_id" {
#  description = "The globally unique identifier for the key"
#  value       = "${aws_kms_key.cdc.*.id}"
#}
#
#output "key_arn" {
#  description = "The Amazon Resource Name (ARN) of the key"
#  value       = "${aws_kms_key.cdc.*.arn}"
#}
#
#output "key_alias_arn" {
#  description = "The Amazon Resource Name (ARN) of the key alias."
#  value       = "${aws_kms_alias.cdc.*.arn}"
#}


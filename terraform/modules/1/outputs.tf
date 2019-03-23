/* aws_kms_key outputs */

output "kms_key_arn" {
  value       = "${aws_kms_key.input.arn}"
  description = "The Amazon Resource Name (ARN) of the key"
}

output "kms_key_id" {
  value       = "${aws_kms_key.input.id}"
  description = "The globally unique identifier for the key"
}

/* aws_kms_alias outputs */

output "kms_alias_arn" {
  value       = "${aws_kms_alias.queue_input.arn}"
  description = "The Amazon Resource Name (ARN) of the key alias"
}

output "kms_alias_target_arn" {
  value       = "${aws_kms_alias.queue_input.target_key_arn}"
  description = "The Amazon Resource Name (ARN) of the target key identifier"
}

/* input aws_sqs_queue outputs */

output "sqs_queue_id" {
  value       = "${aws_sqs_queue.input.id}"
  description = "The URL for the created Amazon SQS queue"
}

output "sqs_queue_arn" {
  value       = "${aws_sqs_queue.input.arn}"
  description = "The ARN of the SQS queue"
}

/* dead letter aws_sqs_queue outputs */

output "dlq_id" {
  value       = "${aws_sqs_queue.dlq.id}"
  description = "The URL for the created Amazon SQS DLQ"
}

output "dlq_arn" {
  value       = "${aws_sqs_queue.dlq.arn}"
  description = "The ARN of the SQS DLQ"
}

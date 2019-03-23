# 1 Module

Adds an SQS queue

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|-------|-------|
| tags | Map of tags to add the every resource | map | - | yes |
| environment | Name of environment in which to run | string | - | yes |
| aws_region | AWS region | string | eu-west-1 | no |
| entity | Microservice name | string | - | yes |
| organisation | AWS organisation ID | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| kms_key_arn | The Amazon Resource Name (ARN) of the key |
| kms_key_id | The globally unique identifier for the key |
| kms_alias_arn | The Amazon Resource Name (ARN) of the key alias |
| kms_alias_target_arn | The Amazon Resource Name (ARN) of the target key identifier |
| sqs_queue_id | The URL for the created Amazon SQS queue |
| sqs_queue_arn | The ARN of the SQS queue |
| dlq_id | The URL for the created Amazon SQS DLQ |
| dlq_arn | The ARN of the SQS DLQ |

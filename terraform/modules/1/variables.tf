variable "tags" {
  type        = "map"
  description = "Map of tags to add the every resource"
}

variable "environment" {
  type        = "string"
  description = "Name of environment in which to run"
}

variable "aws_region" {
  default     = "eu-west-1"
  type        = "string"
  description = "AWS region"
}

variable "entity" {
  description = "Microservice name"
  type        = "string"
}

variable "organisation" {
  description = "AWS organisation ID"
  type        = "string"
}

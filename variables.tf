variable "region" {
  description = "AWS Region to create infrastructure in"
  type        = string
  default     = "eu-west-1"
}

variable "aws_profile" {
  description = "AWS Profile name"
  type        = string
  default     = "tf"
}

variable "aws_credentials_path" {
  description = "AWS Credentials file"
  type        = string
  default     = "/home/ubuntu/.aws/credentials"
}

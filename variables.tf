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

variable "instances_per_subnet" {
  description = "Number of instances to run on each subnet"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "AMI ID to lunch EC instance"
  type        = string

  validation {
    condition     = startswith(var.ami_id, "ami-")
    error_message = "AMI ID should start with \"ami-\" prefix"
  }
  validation {
    condition     = length(var.ami_id) >= 12
    error_message = "AMI ID should be at least 12 characters long"
  }
}

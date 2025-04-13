variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of the AWS key pair"
  default     = "devops-key"  # Replace with your actual key pair name
}


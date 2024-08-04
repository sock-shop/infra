variable "repository_names" {
  description = "List of ECR repository names"
  type        = list(string)
  default     = ["front-end", "catalogue"]  # Add your default repo names here
}

variable "repository_group" {
  description = "The group where the ECR repository belongs"
  type        =  string
  default     = "sock-shop/"
}

variable "user_identifiers" {
  type        =  list(string)
  default     = ["885801475464"]
}

variable "user_group" {
  type        =  string
  default     = "Developers"
}
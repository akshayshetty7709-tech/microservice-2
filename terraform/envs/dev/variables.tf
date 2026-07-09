variable "aws_region"           { type = string default = "us-east-1" }
variable "name_prefix"          { type = string default = "locate360" }
variable "frontend_bucket_name" { type = string }
variable "ssh_public_key"       { type = string }
variable "allowed_ssh_cidrs"    { type = list(string) default = [] }
variable "tags" {
  type = map(string)
  default = { Project = "locate360", ManagedBy = "terraform" }
}

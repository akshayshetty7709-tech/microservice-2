variable "name_prefix"          { type = string }
variable "subnet_ids"           { type = list(string) }
variable "security_group_id"    { type = string }
variable "ssh_public_key"       { type = string }
variable "master_instance_type" { type = string  default = "t3.medium" }
variable "worker_instance_type" { type = string  default = "t3.medium" }
variable "worker_count"         { type = number  default = 2 }
variable "tags"                 { type = map(string) default = {} }

variable "name_prefix"         { type = string }
variable "vpc_cidr"            { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "azs"                 { type = list(string) }
variable "allowed_ssh_cidrs"   { type = list(string) default = ["0.0.0.0/0"] }
variable "tags"                { type = map(string) default = {} }

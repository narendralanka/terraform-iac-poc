
variable "project"                 { type = string }
variable "environment"             { type = string }
variable "subnet_id"               { type = string }
variable "vpc_security_group_ids"  { type = list(string) }
variable "instance_type"           { type = string }
variable "tags"                    { type = map(string) default = {} }

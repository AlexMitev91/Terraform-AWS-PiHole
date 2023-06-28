variable "cidr_block_allow" {
  default = "0.0.0.0/0"
}

variable "pi-ports-tcp" {
  type = list(number)
  description = "List of ingress ports"
  default = [22,80,53]
}
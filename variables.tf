variable "hcloud_token" {
    type = string
    description = "The token that is used to interact with the Hetzner Cloud API."
}

variable "server_count" {
    type = number
    default = 1
    description = "Number of servers"
}

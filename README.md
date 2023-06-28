# Armbian compile for Odroid MC1

These scripts create a virtual machine in the Hetzner Cloud with Terraform, and sets it up with Ansiblee to compile Armbian for Odroid MC1.

## How to use it

Terraform and Ansible have to be installed.

1. Clone repository
1. Change SSH key name in _main.tf_ (line with _ssh_keys_)  
   The key has to exist in the Hetzner Cloud instance
1. ```terraform init -upgrade```
1. ```export HCLOUD_TOKEN=<token>```
1. ```./up.sh```
1. Use the VM to compile Armbian
1. ```./down.sh```

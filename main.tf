# VMs
resource "hcloud_server" "rancher_mgmt_nodes" {
    name = "odroid-compile"
    image = "ubuntu-22.04"
    server_type = "cx11" # cpx41
    location = "nbg1"
    ssh_keys = [ "sgaspar@mbsgaspar", "sascha@router.homenet.saschagaspar.net" ]
}

resource "local_file" "hosts_cfg" {
    content = templatefile(
        "${path.module}/inventory.tftpl",
        {
            user = "root"
            nodes = hcloud_server.rancher_mgmt_nodes.*.ipv4_address
        }
    )
    filename = "./inventory.yml"
}

resource "local_file" "setup_sh" {
    content = templatefile(
        "${path.module}/setup.tftpl",
        {
            nodes = hcloud_server.rancher_mgmt_nodes.*.ipv4_address
        }
    )
    filename = "./setup.sh"
}

resource "terraform_data" "script" {
    depends_on = [
        local_file.hosts_cfg,
        local_file.setup_sh,
        hcloud_server.rancher_mgmt_nodes
    ]

    provisioner "local-exec" {
        command = <<EOT
            sleep 10
            ./setup.sh
            # ansible-playbook -u root -i inventory.yml ../Ansible/update.yaml
            ansible -i inventory.yml all -m ping
        EOT
    }
}
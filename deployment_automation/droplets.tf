# Setup a new project for our instances to reside in
resource "digitalocean_project" "demo_project" {
    name = "digitalocean_project"
    description = "Namespace for our smal demo project"
    purpose = "Demonstration of IoT Project with automatic deployment pipeline"
    environment = "Development"
    resources = digitalocean_droplet.demo.*.urn
}

# Generate new SSH keys for the infrastructure setup
resource "digitalocean_ssh_key" "keys" {
    name = "iot-demo-setup-keys"
    public_key = tls_private_key.ssh.public_key_openssh
}

# Definen the VM/Droplet(s) to be deployed
resource "digitalocean_droplet" "demo" {
    count = 2
    image = "docker-20-04"
    name = "demo-setup${count.index}"
    region = "fra1"
    size = "s-1vcpu-1gb"
    user_data = file("user_config.yaml")

    ssh_keys = [
        digitalocean_ssh_key.keys.id
    ]

    provisioner "remote-exec" {
        inline = [
            "echo 'NOW: Established SSH-Connection to client'",
           # "sudo apt update", # Enable these lines if you want to do a update&upgrade upon first connection
           # "sudo apt upgrade -y", # Enable these lines if you want to do a update&upgrade upon first connection
           # "echo Done!" # Enable these lines if you want to do a update&upgrade upon first connection
            ]
        connection {
            host = self.ipv4_address
            type = "ssh"
            user = "root"
            private_key = tls_private_key.ssh.private_key_openssh
        }
    }

    provisioner "local-exec" {
        #command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address}' --private-key ${tls_private_key.ssh.private_key_openssh} -e 'pub_key=${tls_private_key.ssh.public_key}' deploy_project.yaml"
        command = "ansible-playbook -u root -i '${self.ipv4_address}' deploy_project.yaml"
    }
}

output "droplet_ip_addresses" {
    value = {
        for droplet in digitalocean_droplet.demo:
        droplet.name => droplet.ipv4_address
    }
}
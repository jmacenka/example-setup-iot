# teraform script which will generate a new local ressoure of type tls_private_key to be used for deploying the new machines
# in a production setup this would be handled by some cloud-vault mechanism like https://learn.hashicorp.com/tutorials/vault/terraform-secrets-engine
# for this demo setup an ephemeral Key is ok.
resource "tls_private_key" "ssh" {
    algorithm = "RSA"
    rsa_bits = "4096"
} # TODO: Figure out how to provide this as a file to the ansible-playbook command

resource "local_file" "ssh_public_key" { 
    filename = "${path.module}/ssh/id_rsa.pub"
    #content = tls_private_key.ssh.public_key_openssh
    content = tls_private_key.ssh
}

resource "local_file" "ssh_privat_key" { 
    filename = "${path.module}/ssh/id_rsa"
    #content = tls_private_key.ssh.private_key_openssh
    content = tls_private_key.ssh

}

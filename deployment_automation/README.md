![ANSIBLE and terraform Image](https://ibm.github.io/cloud-enterprise-examples/static/ced342e4102a26420170f80f60846589/1ec2b/IaC-Ansible_Design_1.png)

# Deployment Automation

By Jan Macenka, last edited 11.08.2022

Automation Pipeline utilizing terraform and Ansible to create the required ressources on the DigitalOcean Cloud (could easily be exchanged for AWS, Azure or any ESXi-Infrastructure)

Will determine the necessary actions with terraform and provision the required ressources (VMs) on the Cloud-Plattform.

Once the VM-Instances are provisioned, terraform will invoke an Ansible playbook which will run a couple of rolles to configure the VM and finally pull and deploy the dockerized environment.

This is meant to show that in a fully automated CD-Pipeline, it takes about 30s to 5min to deploy staged code into newly setup infrastructure. This way we will have all of our Infrastructure as Code and e.g. in Case of Desaster we can easily re-deploy the same Infrastructure again. This however does not take care of backing-up the Data which can either be done from within the application or as a separate outside backup step.

To run the deployment peform the following steps:

1. Make sure you have the require dependencies installed on your machine
   - [SSH](https://docs.microsoft.com/de-de/windows-server/administration/openssh/openssh_install_firstuse) (only required on Windows as Linux and Mac usually come with essential CLI-tools preinstalled)
   - [GIT](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   - [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
   - [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
2. Login to [https://digitalocean.com](https://digitalocean.com)
3. Go to the [Token-Section](https://cloud.digitalocean.com/account/api/tokens) and [create a new Personal Access Token](https://cloud.digitalocean.com/account/api/tokens/new) or regenerate an already existing one which you previously used and have not connected to a active pipeline
4. Take the Token to your clipboard (Crtl+C)
5. Start a Shell inside the folder this document resides in and launch the terraform script with a sequence of the following commands:
   - `terraform init` => Will initialize the neccesarry terraform communication-modules on your system
   - `terraform plan` => Will ask you for your API-Key which you need to provide, this commant will generate a plan on what needs to be done on the cloud plattform to have your required amount of ressources/VMs avaliable
   - `terraform apply -auto-approve` => Will ask you for your API-Key which you then need to provide, this command will run the deployment-command which does the following steps:
     - create a new ephemeral SSH-Key-Pair which will be used to login to the newly created VMs
     * delete old instance of the VM if it is different from the required profile
     * create as many new Projects, Namespaces and VMs as specified based on the available Images of the cloud plattform
     * once the VMs are up, register the SSH-Keys with the new machines
     * in parallel, login to each new machine and start executing the Ansible-Script
6. Go and inspect the newly deployed web-services, for this see [this presentation](https://url.macenka.de/demo_setup)
7. After you are done with experimenting the Webservices, destroy the commissioned machines again with the command `terraform destroy -auto-approve`

Please note how the entire process of setting up and deploying everything takes only minutes. The teardown process takes even less time. If you want to get more information about what happens before the `terraform apply` and `terraform destroy` command, you can omit the the `-auto-approve` option and will be asked to interactively confirm the displayed changes.

In a production setup the handling of secrets like the API-Key will usually be handled by invoking [some service like this one](https://www.hashicorp.com/blog/managing-credentials-in-terraform-cloud-and-enterprise).

That is the speed required to be relevant in the modern age of digitalization. Which we want to establish in your organization.

Regards,

[_Jan Macenka_](mailto:jan@macenka.de?subject=Request%20regarding%20Infrastructure%20as%20Code%20Pipelines&body=Dear%20Jan,%20lets%20talk%20about...)

# Jenkins project
## About the project
  The project provisioning Jenkins master server and his two slave nodes by using Terraform. Then it installs Jenkins and all needed utilities on the master and the slave servers, starts the Jenkins service, configures credentials for GitHub and slaves, adds slave agents, and creates two jobs from files using Ansible.
  * The first job is for provisioning the Wagtail project from this GitHub account.
  * The second job is for provisioning the Kubernetes project from this GitHub Account.
## What do you need to deploy 
  * Linux server
  * [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  * [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
  * [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
  * Put your GitHub SSH key in ~/.ssh/ directory if exist or reate SSH key and register it in your GitHub acc.
  * And last but not least. You need DNS name rigeistered in Route53.
## To deploy the project perform next Linux shell commands 
  * Create directory for project and change current directory to project directrory
```
mkdir ~/project
cd ~/project
```
  * Cloning repo of this project
```
git clone git@github.com:VlN9/Jenkins-AWS-server.git
```
  * Change dir to project dir
```
cd Jenkins-AWS-server
```
  * Also you need to configure prod.tfvars file because you need add your own DNS name and other little details.
  * Preform terraform command
```
terraform apply -auto-approve -var-file=jenkins.tfvars
```

## After these steps, you already have ready to work Jenkins service

You need to open browser and type URL string jenkins.\<\your-dns.com>, sing-in to service.<br>
login: jenkins<br>
password: 123
# Good Luck



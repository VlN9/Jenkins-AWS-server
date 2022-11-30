resource "null_resource" "add_hosts" {
  provisioner "local-exec" {
    command = "echo ${aws_instance.jen_server.public_ip} >> /home/vladimir/Projects/terraform-project/ansible/hosts.txt"
  }
  depends_on = [
    aws_instance.jen_server
  ]
}

resource "null_resource" "activate-ansible" {
  provisioner "local-exec" {
    command = "sleep 3 && ansible-playbook /home/vladimir/Projects/terraform-project/ansible/playbook-jen-ans.yaml"
  }
  depends_on = [
    aws_instance.jen_server
  ]
}

resource "null_resource" "jenkins_password" {
  provisioner "local-exec" {
    command = "sleep 3 && ansible prod_servers -m shell -a \"cat /var/lib/jenkins/secrets/initialAdminPassword\" -b"
  }
  depends_on = [
    aws_instance.jen_server,
    null_resource.activate-ansible
  ]
}

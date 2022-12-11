resource "null_resource" "server_ip" {
 provisioner "local-exec" {
   command = "ansible prod_servers -m shell -a \"export JENKINS_IP=http://${aws_instance.jen_server.public_ip}:8080\""
 }
 depends_on = [
   null_resource.activate-ansible,
   aws_instance.jen_server
 ]
}

resource "null_resource" "add_hosts" {
  provisioner "local-exec" {
    command = "echo \"[prod_servers]\n${aws_instance.jen_server.public_ip}\" > ./hosts.txt"
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

resource "null_resource" "activate-jenkins" {
  provisioner "local-exec" {
    command = "ansible-playbook --extra-vars=\"jenkins_ip=${aws_instance.jen_server.public_ip}\" /home/vladimir/Projects/terraform-project/ansible/playbook-activate-jenkins.yaml"
  }
  depends_on = [
    aws_instance.jen_server,
    null_resource.activate-ansible
  ]
}

resource "null_resource" "add_hosts" {
  provisioner "local-exec" {
    command = "echo \"[master_server]\n${aws_instance.jen_server.public_ip}\n[slave_server]\n${aws_instance.slave_server.public_ip}\" > ./hosts.txt"
  }
  depends_on = [
    aws_instance.jen_server,
    aws_instance.slave_server
  ]
}

resource "null_resource" "activate-ansible" {
 provisioner "local-exec" {
   command = "sleep 3 && ansible-playbook /home/vlad/project/Jenkins-AWS-server/ansible/playbook-jen-ans.yaml"
 }
 depends_on = [
   aws_instance.jen_server,
   aws_instance.slave_server
 ]
}

resource "null_resource" "prvt_ip_for_slave" {
  provisioner "local-exec" {
    command = "echo \"${aws_instance.slave_server.private_ip}\" > ./ansible/prvt_ip"
  }
  depends_on = [
    aws_instance.jen_server,
    aws_instance.slave_server
  ]
}

resource "null_resource" "activate-jenkins" {
 provisioner "local-exec" {
   command = "ansible-playbook  /home/vlad/project/Jenkins-AWS-server/ansible/playbook-activate-jenkins.yaml"
 }
 depends_on = [
   aws_instance.jen_server,
   null_resource.activate-ansible
 ]
}

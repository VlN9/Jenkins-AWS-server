resource "null_resource" "add_hosts" {
  provisioner "local-exec" {
    command = "echo \"[master_server]\n${aws_instance.jen_server.public_ip}\n[slave_server]\n${aws_instance.slave_server[0].public_ip}\n${aws_instance.slave_server[1].public_ip}\" > ./hosts.txt"
  }
  depends_on = [
    aws_instance.jen_server,
    aws_instance.slave_server
  ]
}

resource "null_resource" "activate-ansible" {
 provisioner "local-exec" {
   command = "sleep 3 && ansible-playbook ./ansible/playbook-jen-ans.yaml --extra-var \"home_path=${var.home_path} slave_key=${var.slave_key} wagtail_key=${var.wagtail_key}\""
 }
 depends_on = [
   aws_instance.jen_server,
   aws_instance.slave_server
 ]
}

resource "null_resource" "prvt_ip_for_wagtail_slave" {
  provisioner "local-exec" {
    command = "echo \"${aws_instance.slave_server[0].private_ip}\" > ./ansible/prvt_wgt_ip"
  }
  depends_on = [
    aws_instance.jen_server,
    aws_instance.slave_server
  ]
}

resource "null_resource" "prvt_ip_for_k8s_slave" {
  provisioner "local-exec" {
    command = "echo \"${aws_instance.slave_server[1].private_ip}\" > ./ansible/prvt_k8s_ip"
  }
  depends_on = [
    aws_instance.jen_server,
    aws_instance.slave_server
  ]
}

resource "null_resource" "activate-jenkins" {
 provisioner "local-exec" {
   command = "ansible-playbook  ./ansible/playbook-activate-jenkins.yaml --extra-var \"slave_key=${var.slave_key} home_path=${var.home_path}\" "
 }
 depends_on = [
   aws_instance.jen_server,
   null_resource.activate-ansible
 ]
}

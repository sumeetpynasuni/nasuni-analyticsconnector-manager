
# instances
resource "aws_instance" "NACManager" {
  ami = "${var.instance_ami}"
  availability_zone = "${lookup(var.availability_zone, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = true
  source_dest_check = false

  security_groups = [
    "${var.vpc_public_sg_id}"]

  tags = {
    Name = "NACManager"
  }

}

output "NACManager_ip" {
  value = "${aws_instance.NACManager.public_ip}"
}

resource "null_resource" "NACManager_IP" {
  provisioner "local-exec" {
    command = "echo ${aws_instance.NACManager.public_ip} > NACManager_IP.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf NACManager_IP.txt"
  }
  depends_on = [aws_instance.NACManager]
}
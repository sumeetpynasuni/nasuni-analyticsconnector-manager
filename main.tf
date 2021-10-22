
# instances
data "aws_region" current {}
resource "aws_instance" "NACManager" {
  ami = var.instance_ami[data.aws_region.current.name]
  availability_zone = "${lookup(var.availability_zone, data.aws_region.current.name)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.aws_key_name[data.aws_region.current.name]}"
  associate_public_ip_address = true
  source_dest_check = false

  root_block_device {
    volume_size = var.volume_size
  }
  # ebs_block_device {
  #   device_name = "/dev/sdb"
  #   volume_type = "gp2"
  #   volume_size = 101
  # }

 provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install jq -y",
      "sudo apt install unzip",
      "sudo apt install curl bash ca-certificates git openssl wget vim -y",
      "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -",
      "sudo apt-add-repository \"deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main\"",
      "sudo apt update",
      "sudo apt install terraform",
      "terraform -v",
      "which terraform",
      "sudo apt install python3 -y",
      "sudo apt install python3-pip -y",
      "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "sudo unzip awscliv2.zip",
      "sudo ./aws/install",
      "aws --version",
      "which aws",
      "aws configure --profile ${var.aws_profile} set aws_access_key_id ${data.local_file.aws_conf_access_key.content}",
      "aws configure --profile ${var.aws_profile} set aws_secret_access_key ${data.local_file.aws_conf_secret_key.content}",
      "aws configure set region ${data.aws_region.current.name} --profile ${var.aws_profile}",
      ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("./${var.aws_key_name[data.aws_region.current.name]}.pem")
  }

  tags = {
    Name = "AAA-NACManager"
  }

depends_on = [
  data.local_file.aws_conf_access_key,
  data.local_file.aws_conf_secret_key,
]
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

resource "null_resource" "aws_conf" {
  provisioner "local-exec" {
     command = "aws configure get aws_access_key_id --profile ${var.aws_profile} | xargs > Xaws_access_key.txt && aws configure get aws_secret_access_key --profile ${var.aws_profile} | xargs > Xaws_secret_key.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf X*key.txt"
  }
}

data "local_file" "aws_conf_access_key" {
  filename   = "${path.cwd}/Xaws_access_key.txt"
  depends_on = [null_resource.aws_conf]
}


data "local_file" "aws_conf_secret_key" {
  filename   = "${path.cwd}/Xaws_secret_key.txt"
  depends_on = [null_resource.aws_conf]
}

output "NACManager_ip" {
  value = "${aws_instance.NACManager.public_ip}"
}



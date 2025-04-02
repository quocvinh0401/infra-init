resource "aws_security_group" "sg" {
  name   = var.name
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "22"
  to_port           = "22"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.key_pair.key_name

  tags = {
    Name = var.name
  }
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${path.root}/ansible/${var.name}-key.pem"
  file_permission = "0400"
}

resource "local_file" "ansible_inventory" {
  content  = <<EOF
[ec2_instances]
ec2_instance ansible_host=${aws_instance.ec2.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file="./${var.name}-key.pem"
EOF
  filename = "${path.root}/ansible/inventory.ini"
}

# resource "null_resource" "run_ansible" {
#   depends_on = [aws_instance.ec2, local_file.ansible_inventory]

#   provisioner "local-exec" {
#     command = "ansible-playbook -i ${path.root}/ansible/inventory.ini ${path.root}/ansible/playbook.yaml"
#   }
# }

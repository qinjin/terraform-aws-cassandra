resource "aws_instance" "cassandra" {
  count         = length(var.private_ips)
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  monitoring    = true
  private_ip    = var.private_ips[count.index]
  root_block_device {
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = false
  }

  vpc_security_group_ids = [aws_security_group.cassandra.id]
  subnet_id              = var.subnet_ids[count.index]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<HERE
#!/bin/bash
read -d '' CONTENT << EOF
${templatefile("${path.module}/template/cassandra.tmpl", { private_ip = var.private_ips[count.index], seeds = "${var.private_ips[0]},${var.private_ips[2]}" })}
EOF
sudo echo "$CONTENT" > /etc/dse/cassandra/cassandra.yaml

yum update -y
systemctl enable cassandra
service cassandra start
HERE

  tags = var.common_tags
}
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = "${var.name_prefix}-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "master" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.master_instance_type
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]
  key_name               = aws_key_pair.this.key_name

  tags = merge(var.tags, { Name = "${var.name_prefix}-k8s-master", Role = "master" })
}

resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.worker_instance_type
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = [var.security_group_id]
  key_name               = aws_key_pair.this.key_name

  tags = merge(var.tags, { Name = "${var.name_prefix}-k8s-worker-${count.index}", Role = "worker" })
}

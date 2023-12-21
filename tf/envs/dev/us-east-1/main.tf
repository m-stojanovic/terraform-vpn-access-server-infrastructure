# SECURITY GROUP
resource "aws_security_group" "openvpn" {
  name        = "${var.product_name}-${var.product_env}-openvpn-server-sg"
  description = "Allow inbound traffic to OpenVPN server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Access UDP 1194 anywhere"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access HTTPS anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access 943 anywhere"
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access 945 anywhere"
    from_port   = 945
    to_port     = 945
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access from Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["1.1.1.1/32"]
  }

  tags = merge(var.tags, tomap({ "Name" = "${var.product_name}-${var.product_env}-openvpn-server-sg" }), tomap({ "TechnicalFunction" = "network" }))
}

# INSTANCE 
resource "aws_key_pair" "openvpn_key" {
  key_name   = "devops-dev-openvpn-server-key"
  public_key = "ssh-rsa xxx/xxx devops@devops.io"
  tags       = merge(var.tags, tomap({ "Name" = "${var.product_name}-${var.product_env}-openvpn-server-key" }), tomap({ "TechnicalFunction" = "network" }))
}

resource "aws_eip" "openvpn" {
  instance = aws_instance.openvpn.id
  domain   = "vpc"
  tags     = merge(var.tags, tomap({ "Name" = "${var.product_name}-${var.product_env}-openvpn-server-eip" }), tomap({ "TechnicalFunction" = "network" }))
}


resource "aws_instance" "openvpn" {
  ami                         = var.marketplace_access_server_ami
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.openvpn_key.key_name
  subnet_id                   = data.aws_subnet.default.id

  vpc_security_group_ids = [aws_security_group.openvpn.id]

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = false
    encrypted             = true
    tags                  = var.tags
  }

  tags = merge(var.tags, tomap({ "Name" = "${var.product_name}-${var.product_env}-openvpn-server" }), tomap({ "OperatingSystem" = "amazon-linux" }))
}

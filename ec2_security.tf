resource "aws_security_group" "tf_sg" {
  name        = "tf_sg"
  vpc_id      = aws_vpc.TF_VPC.id

  dynamic "ingress" {
    for_each = var.sg_ports 
    content {
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf_sg"
  }
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}
resource "aws_key_pair" "generated_key" {
  key_name   = "tf_key"
  public_key = tls_private_key.private_key.public_key_openssh
}


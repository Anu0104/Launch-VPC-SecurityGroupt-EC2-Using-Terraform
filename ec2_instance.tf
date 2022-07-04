resource "aws_instance" "tf_instance" {
  ami           = "ami-08df646e18b182346"
  instance_type = "t2.micro"
  key_name = aws_key_pair.generated_key.id
  security_groups = [aws_security_group.tf_sg.id]
  subnet_id = aws_subnet.tf-subnet[0].id
  tags = {
    Name = "tf_instance"
  }
}

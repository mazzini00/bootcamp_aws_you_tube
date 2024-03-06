resource "aws_iam_role" "ec2_s3_read_role" {
  name = "ec2_s3_read_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_read_only" {
  role       = aws_iam_role.ec2_s3_read_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_s3_read" {
  name = "ec2_s3_read"
  role = aws_iam_role.ec2_s3_read_role.name
}

resource "aws_instance" "this" {
  ami           = var.ami           # "ami-0fc5d935ebf8bc3bc"
  instance_type = var.instancia
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  key_name = var.chave
  security_groups = [var.security_groups]

 # user_data = file("${path.module}/script.sh")

  user_data = <<-EOF
              #!/bin/bash
              echo "Iniciando script de user_data"
              echo "Iniciando script de user_data"
              sudo apt-get update -y 
              sudo apt -y install software-properties-common
              sudo add-apt-repository ppa:ondrej/php -y
              sudo apt-get install apache2 php7.4 libapache2-mod-php7.4 php7.4-common php7.4-curl php7.4-intl php7.4-mbstring php7.4-json php7.4-xmlrpc php7.4-soap php7.4-mysql php7.4-gd php7.4-xml php7.4-cli php7.4-zip wget mysql-client unzip git binutils ruby -y
              # sudo apt-get update
              # sudo apt-get install apache2 php7.4 libapache2-mod-php7.4 php7.4-common php7.4-curl php7.4-intl php7.4-mbstring php7.4-json php7.4-xmlrpc  
              # php7.4-soap php7.4-mysql php7.4-gd php7.4-xml php7.4-cli php7.4-zip wget mysql-client unzip git binutils ruby -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              sudo systemctl restart apache2
              wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
              chmod +x ./install
              sudo ./install auto
              sudo service codedeploy-agent start
              sudo chmod 777 /etc/init.d/codedeploy-agent
              sudo wget https://s3.sa-east-1.amazonaws.com/pages.cloudtreinamentos.com/aws/bootcamp/bootcamp10.zip 
              sudo unzip -o bootcamp10.zip -d /var/www/html/
              sudo rm /var/www/html/index.html
              sudo chmod -R 777 /var/www/html
              EOF


metadata_options {
  http_tokens = "optional"
  http_endpoint = "enabled"
  http_put_response_hop_limit = 1
}
  
  tags = {
    Name = "${var.application_name}-public-ec2"
  } 
}


resource "aws_key_pair" "chave-ssh" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")

}

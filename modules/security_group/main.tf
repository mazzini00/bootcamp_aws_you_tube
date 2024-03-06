resource "aws_security_group" "app_sg_ssh" {
    name = "${var.application_name}-app-sg-ssh"
    vpc_id = var.vpc_id
    
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]  # Permitir acesso de qualquer IP
    }
    
    # ingress{
    #     from_port = 80
    #     to_port = 80
    #     protocol = "tcp"
    #     cidr_blocks = [ "0.0.0.0/0" ]
    #     ipv6_cidr_blocks = [ "::/0" ]  
    # }
   
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]    
  }
}
# resource "aws_security_group" "db_sg" {
#     name = "db_sg"
#     description = "Security group for database servers"
#   #  count = var.name == "db-mysql" ? 1 : 0
    
#     ingress {
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]  # Permitir acesso de qualquer IP
#     }
    
#     ingress{
#         from_port = 3306
#         to_port = 3306
#         protocol = "tcp"
#         cidr_blocks = [ "0.0.0.0/0" ]
#         ipv6_cidr_blocks = [ "::/0" ]   
#     }
   
#     egress{
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = [ "0.0.0.0/0" ]
#         ipv6_cidr_blocks = [ "::/0" ]   
#     }
    
#     # tags = {
#     #    Name = var.name
#     # }
# }
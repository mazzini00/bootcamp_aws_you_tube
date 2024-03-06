module "vpc" {
    source = "../modules/vpc"
    application_name = local.application_name
  
}

module "ec2" {
    source = "../modules/ec2"
    ami = "ami-0fc5d935ebf8bc3bc"
    instancia = "t2.micro"
    chave = "chave"
    vpc_id = module.vpc.vpc_id 
    application_name = local.application_name
    subnet_id = module.vpc.subnet_b_id 
    security_groups = module.security_group.security_group_id
   # user_data = file("${path.module}/script.sh")
}


module "security_group" {
    source = "../modules/security_group"
    vpc_id = module.vpc.vpc_id 
    application_name = local.application_name


}
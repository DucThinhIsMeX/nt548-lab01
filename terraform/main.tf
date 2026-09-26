module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
}
module "public_sg" {
  source = "./modules/security_group"

  name   = "${var.project_name}-public-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      description              = "SSH tu IP nguoi dung"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = [var.my_ip]
      source_security_group_id = null
    }
  ]
}

module "private_sg" {
  source = "./modules/security_group"

  name   = "${var.project_name}-private-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      description              = "SSH tu public EC2"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = module.public_sg.security_group_id
    }
  ]
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "public_ec2" {
  source              = "./modules/ec2"
  name                = "${var.project_name}-public-ec2"
  ami_id              = data.aws_ami.amazon_linux.id
  subnet_id           = module.vpc.public_subnet_id
  security_group_id   = module.public_sg.security_group_id
  key_name            = "vockey"
  associate_public_ip = true
}

module "private_ec2" {
  source              = "./modules/ec2"
  name                = "${var.project_name}-private-ec2"
  ami_id              = data.aws_ami.amazon_linux.id
  subnet_id           = module.vpc.private_subnet_id
  security_group_id   = module.private_sg.security_group_id
  key_name            = "vockey"
  associate_public_ip = false
}
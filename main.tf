module "vpc" {
  source = "./modules/vpc"

  name            = var.name
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24"]
  private_subnets = ["10.0.2.0/24"]
}

module "ec2" {
  source = "./modules/ec2"

  name          = var.name
  ami           = "ami-01938df366ac2d954"
  instance_type = "t3.xlarge"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets[0]
}

module "network1" {
 source = "./network"
 vpc_cidr = var.vpc_cidr
 subnet_cidrs = var.subnet_cidrs
}

module "compute" {
  source = "./compute"
  instance_type = var.instance_type
  subnet_id = module.network1.subnet_ids[0]
}

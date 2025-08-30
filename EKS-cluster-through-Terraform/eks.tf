module "eks" {
  # Import the module template
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # Cluster Info (Control plane)
  name                     = local.name
  kubernetes_version       = "1.33"
  endpoint_public_access   = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets

  addons = {
        vpc-cni = {
          most-recent = true
        }
        kube-proxy = {
          most-recent = true
        }
        coredns = {
          most-recent = true
        }
  } 

  # Control plane network
  control_plane_subnet_ids = module.vpc.intra_subnets


  # Managing nodes in the cluster
  eks_managed_node_groups = {
    tws-cluster-ng = {
      instance_types = ["c7i-flex.large"]

      min_size     = 2
      max_size     = 3
      desired_size = 2

      capacity_type = "SPOT"
    }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}


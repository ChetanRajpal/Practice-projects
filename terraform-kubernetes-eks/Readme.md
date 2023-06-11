# EKS Kubernetes Cluster Deployment using Terraform

 I used terraform to deploy an EKS cluster. The terraform script is follows as given below


    provider "aws" {
      region = "us-east-1"
    }
    
    data "aws_availability_zones" "available" {}
    
    data "aws_eks_cluster" "cluster" {
      name = module.eks.cluster_id
    }
    
    data "aws_eks_cluster_auth" "cluster" {
      name = module.eks.cluster_id
    }
    
    locals {
      cluster_name = "terra-eks-test-1"
    }
    
    provider "kubernetes" {
      host                   = data.aws_eks_cluster.cluster.endpoint
      cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
      token                  = data.aws_eks_cluster_auth.cluster.token
    }
    
    module "eks-kubeconfig" {
      source     = "hyperbadger/eks-kubeconfig/aws"
      version    = "1.0.0"
    
      depends_on = [module.eks]
      cluster_id =  module.eks.cluster_id
      }
    
    resource "local_file" "kubeconfig" {
      content  = module.eks-kubeconfig.kubeconfig
      filename = "kubeconfig_${local.cluster_name}"
    }

    module "vpc" {
      source  = "terraform-aws-modules/vpc/aws"
      version = "5.0.0"
    
      name                 = "test-eks-vpc"
      cidr                 = "10.0.0.0/16"
      azs                  = data.aws_availability_zones.available.names
      private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
      enable_nat_gateway   = true
      single_nat_gateway   = true
      enable_dns_hostnames = true
    
      public_subnet_tags = {
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
        "kubernetes.io/role/elb"                      = "1"
      }
    
      private_subnet_tags = {
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
        "kubernetes.io/role/internal-elb"             = "1"
      }
    }
    
    module "eks" {
      source  = "terraform-aws-modules/eks/aws"
      version = "18.30.3"
    
      cluster_name    = "${local.cluster_name}"
      cluster_version = "1.24"
      subnet_ids      = module.vpc.private_subnets
    
      vpc_id = module.vpc.vpc_id
    
      eks_managed_node_groups = {
        first = {
          desired_capacity = 2
          max_capacity     = 2
          min_capacity     = 1
    
          instance_type = "t2.micro"
        }
      }
    }
	
 
 ## Screenshots -
 
 ### 1
 
 Here I used command `terraform init`
 
 <img src="./screenshots/1.png" alt="Alt text" title="Screenshot 1">
 
 ### 2
 
 Here I used command `terraform plan`
 
 <img src="./screenshots/2.png" alt="Alt text" title="Screenshot 2">
 
 ### 3
 
 <img src="./screenshots/3.png" alt="Alt text" title="Screenshot 3">
 
 ### 4
 
 Here I used command `terraform apply --auto-approve`
 
 <img src="./screenshots/4.png" alt="Alt text" title="Screenshot 4">
 
 ### 5
 
 <img src="./screenshots/5.png" alt="Alt text" title="Screenshot 5">



 Before proceeding forward donot forget to add path for generated kubeconfig_ file in the active directory. `export KUBECONFIG="${PWD}/kubeconfig_<cluster-name>"`


 
  ### 6
  
  Here I used command `kubectl get nodes`. You can see that there is only one node. It is because I defined terraform to create only one node of t2.micro previously.
 
 <img src="./screenshots/6.png" alt="Alt text" title="Screenshot 6">
 
  
  
  I also faced one issue where it was not authenticated and in order to fix that authentication problem, I used this command `aws eks update-kubeconfig --region <region-name> --name terra-<cluster-name>`
  
  
  ### 7
  
  Here I used `kubectl apply -f deploy.yaml` to deploy my portfolio image on the pod. To test my pod I used ` kubectl port-forward test-chetan-portfolio-694f5cfbfc-89jsp 80:80`
 
 <img src="./screenshots/7.png" alt="Alt text" title="Screenshot 7">
 
  ### 8
 
 <img src="./screenshots/8.png" alt="Alt text" title="Screenshot 8">
 
 
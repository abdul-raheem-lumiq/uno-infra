# # Create Key pair
# resource "aws_key_pair" "eks-key-pair" {
# key_name = var.eks-key-pair
# public_key = tls_private_key.rsa.public_key_openssh
# }
# resource "tls_private_key" "rsa" {
# algorithm = "RSA"
# rsa_bits  = 4096
# }
# resource "local_file" "tf-key" {
# content  = tls_private_key.rsa.private_key_pem
# filename = "./${var.eks-key-pair}"
# }

# EKS cluster
resource "aws_eks_cluster" "eks-cluster"{
    name = var.eks-name
    role_arn = "${aws_iam_role.eks-iam-role.arn}"
    version = var.version-cluster

#VPC Network configuration
vpc_config {
        security_group_ids = [aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id]       
        subnet_ids = ["${var.privatesubnet1}","${var.privatesubnet2}"]
        endpoint_public_access=var.endpoint_public_access
        endpoint_private_access=var.endpoint_private_access
}

#Cluster Log Types 
enabled_cluster_log_types = var.logtypes #CHANGEIT

#Iam role attaching to eks cluster.
depends_on = [
       aws_iam_role_policy_attachment.eks-iam-role-AmaoznEKSClusterPolicy,
       aws_iam_role_policy_attachment.eks-iam-role-AmazonEKSVPCResourceController,
 ]
}

#NodeGroups for EKS cluster
resource "aws_eks_node_group" "worker-node-group" {
       cluster_name  = aws_eks_cluster.eks-cluster.name
       node_group_name = var.ng-name
       node_role_arn  = aws_iam_role.workernodes.arn
       subnet_ids = ["${var.privatesubnet1}","${var.privatesubnet2}"]
       #instance_types = ["t3.xlarge"]
 
#NodeGroup configuration
        ami_type       = var.ami_type
        disk_size      = var.disk_size
        #instance_types = "t3.medium"

#Scaling Configuration
scaling_config {
        desired_size = var.pvt_desired_size
        max_size   = var.pvt_max_size
        min_size   = var.pvt_min_size
}

#Enabling ssh access to nodes
#remote_access {
#      ec2_ssh_key = "var.aws_key_pair"
#      source_security_group_ids = [aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id] 
#}
#Update config for nodes
update_config {
        max_unavailable = 1    #PERCENTAGE OR NUMBER CAN BE ACCEPTED HERE.
    #max_unavailable_percentage = 50    # ANY ONE TO USE
}

#Tags for EKS nodegroup
tags = {
       Name = "${var.ng-name}-private"
}

#Nodegroup depends on IAM role.
  depends_on = [
        aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

#IAM ROLE POLICY FOR EKS CLUSTER
resource "aws_iam_role" "eks-iam-role" {
       name = var.eks_iam_role #CHANGEIT
       # path = "/"
                assume_role_policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
		"Effect": "Allow",
		"Principal": {
			"Service": "eks.amazonaws.com"
		},
		"Action": "sts:AssumeRole"
	}]
}
EOF
}

#IAM ROLE for eks cluster
resource "aws_iam_role_policy_attachment" "eks-iam-role-AmaoznEKSClusterPolicy" {
       policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
       role = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "eks-iam-role-AmazonEKSVPCResourceController"{
       policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
       role = aws_iam_role.eks-iam-role.name
}

#IAM ROLE POLICY FOR WORKER NODES
resource "aws_iam_role" "workernodes" {
       name = "eks-node-group-example" #CHANGEIT
 
               assume_role_policy = jsonencode({
               Statement = [{
               Action = "sts:AssumeRole"
               Effect = "Allow"
               Principal = {
               Service = "ec2.amazonaws.com"
            }
        }]
       Version = "2012-10-17"
    })
 }
 
 #Attaching ROLE to policy
 resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        role    = aws_iam_role.workernodes.name
 }
 
 #Attaching ROLE to policy
 resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        role    = aws_iam_role.workernodes.name
 }
 
 #Attaching ROLE to policy
 resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
        policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
        role    = aws_iam_role.workernodes.name
 }
 resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess" {
        policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
        role    = aws_iam_role.workernodes.name
 }
 
 #Attaching ROLE to policy
 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        role    = aws_iam_role.workernodes.name
}


#Addons for EKS Cluster
resource "aws_eks_addon" "addons" {
  for_each          = { for addon in var.addons : addon.name => addon }
  cluster_name      = aws_eks_cluster.eks-cluster.id
  addon_name        = each.value.name
  addon_version     = each.value.version
  resolve_conflicts = "OVERWRITE"
}


variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
    {
      name    = "kube-proxy"
      version = "v1.21.2-eksbuild.2" #CHANGEIT
    },
    {
      name    = "vpc-cni"
      version = "v1.10.1-eksbuild.1" #CHANGEIT
    },
    
      #{
      #name    = "coredns"
      #version = "v1.8.7-eksbuild.1" #CHANGEIT
    #}
  ]
}

#Cluster Security Group
resource "aws_security_group" "eks_cluster" {
  name        = var.eks-name-sg
  description = "Cluster communication with worker nodes"
  vpc_id = "${var.aws_vpc}"

    egress  {   #CHANGEIT
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
   ingress  {                                #CHANGEIT
       description      = "TLS from VPC"
       from_port        = 443
       to_port          = 443
       protocol         = "tcp"
       cidr_blocks      = ["0.0.0.0/0"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  tags = {
    Name = var.eks-name-sg  #CHANGEIT
  }
}


#Security Group For Nodes
resource "aws_security_group" "eks_nodes" {
  name        = var.nodes_sg_name-eks-nodes
  description = "Security group for all nodes in the cluster"
  vpc_id = "${var.aws_vpc}"

 egress {       #CHANGEIT
        from_port   = 0   
        to_port     = 0 
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress  {  #CHANGEIT
       description      = "TLS from VPC"
       from_port        = 0
       to_port          = 0
       protocol         = "-1"
       cidr_blocks      = ["0.0.0.0/0"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }


    tags = {   #CHANGEIT
       Name                                    = "var.ng-name"
       "kubernetes.io/cluster/${var.eks-name}" = "owned"
    }
}

data "tls_certificate" "eks_oidc_issuer" {
  url = resource.aws_eks_cluster.eks-cluster.identity.0.oidc.0.issuer
}

# Create OIDC provider for EKS in IAM, to facilitate linking serviceaccount with IAM role. 
resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_issuer.certificates[0].sha1_fingerprint]
  url             = resource.aws_eks_cluster.eks-cluster.identity.0.oidc.0.issuer
}


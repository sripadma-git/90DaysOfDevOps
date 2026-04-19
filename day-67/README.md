## Complete Project Structure

```
terraweek-capstone/
├── main.tf                    # Root module — calls all 3 child modules
├── variables.tf               # Input variables with validation blocks
├── outputs.tf                 # Root outputs (vpc_id, subnet_id, sg_id, instance_id, public_ip)
├── providers.tf               # AWS provider + S3 remote backend
├── locals.tf                  # Workspace-aware locals (environment, name_prefix, common_tags)
├── dev.tfvars                 # Dev environment values
├── staging.tfvars             # Staging environment values
├── prod.tfvars                # Prod environment values
├── .gitignore                 # Ignores .terraform/, *.tfstate, *.tfvars
├── modules/
    ├── vpc/
    │   ├── main.tf            # aws_vpc, aws_subnet, aws_internet_gateway, aws_route_table, aws_route_table_association
    │   ├── variables.tf       # cidr, public_subnet_cidr, environment, project_name
    │   └── outputs.tf         # vpc_id, subnet_id
    ├── security-group/
    │   ├── main.tf            # aws_security_group — dynamic ingress + allow-all egress
    │   ├── variables.tf       # vpc_id, ingress_ports, environment, project_name
    │   └── outputs.tf         # sg_id
    └── ec2-instance/
        ├── main.tf            # aws_instance with environment tags
        ├── variables.tf       # ami_id, instance_type, subnet_id, security_group_ids, environment, project_name
        └── outputs.tf         # instance_id, public_ip
```

---

## Module 1 — `modules/vpc/`

### `variables.tf`
```hcl
variable "cidr"               { type = string }
variable "public_subnet_cidr" { type = string }
variable "environment"        { type = string }
variable "project_name"       { type = string }
```

### `main.tf`
```hcl
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.environment}-${var.project_name}-VPC"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-${var.project_name}-Public-Subnet"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-${var.project_name}-Internet-Gateway"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "${var.environment}-${var.project_name}-Public-Route-Table"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
```

### `outputs.tf`
```hcl
output "vpc_id"    { value = aws_vpc.vpc.id }
output "subnet_id" { value = aws_subnet.public_subnet.id }
```

---

## Module 2 — `modules/security-group/`

### `variables.tf`
```hcl
variable "vpc_id"        { type = string }
variable "ingress_ports" { type = list(number) }
variable "environment"   { type = string }
variable "project_name"  { type = string }
```

### `main.tf`
```hcl
resource "aws_security_group" "sg" {
  name        = "${var.project_name}-${var.environment}-SG"
  description = "Security group with dynamic allowed ports"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-Sg"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
```

### `outputs.tf`
```hcl
output "sg_id" { value = aws_security_group.sg.id }
```

---

## Module 3 — `modules/ec2-instance/`

### `variables.tf`
```hcl
variable "ami_id"             { type = string }
variable "instance_type"      { type = string }
variable "subnet_id"          { type = string }
variable "security_group_ids" { type = list(string) }
variable "environment"        { type = string }
variable "project_name"       { type = string }
```

### `main.tf`
```hcl
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name        = "${var.project_name}-${var.environment}-Server"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
```

### `outputs.tf`
```hcl
output "instance_id" { value = aws_instance.ec2_instance.id }
output "public_ip"   { value = aws_instance.ec2_instance.public_ip }
```

---

## Root `main.tf` — Workspace-Aware Module Calls

```hcl
# Data source — auto-fetch latest Amazon Linux 2 AMI (no hardcoding)
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter { name = "name"               values = ["amzn2-ami-hvm-*-x86_64-*"] }
  filter { name = "virtualization-type" values = ["hvm"] }
  filter { name = "architecture"       values = ["x86_64"] }
  filter { name = "root-device-type"   values = ["ebs"] }
}

# Module 1 — VPC (environment driven by terraform.workspace via locals)
module "vpc" {
  source             = "./modules/vpc"
  cidr               = var.vpc_cidr
  public_subnet_cidr = var.subnet_cidr
  environment        = local.environment   # "dev" / "staging" / "prod"
  project_name       = var.project_name
}

# Module 2 — Security Group (receives vpc_id from module.vpc output)
module "security_group" {
  source        = "./modules/security-group"
  vpc_id        = module.vpc.vpc_id
  ingress_ports = var.ingress_ports
  environment   = local.environment
  project_name  = var.project_name
}

# Module 3 — EC2 Instance (receives AMI, subnet, SG from other modules/data)
module "ec2" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux_2.id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.security_group.sg_id]
  environment        = local.environment
  project_name       = var.project_name
}
```

---

## Three tfvars Files — Differences Highlighted

```hcl
# ── dev.tfvars ─────────────────────────────────────
vpc_cidr      = "10.0.0.0/16"
subnet_cidr   = "10.0.1.0/24"
instance_type = "t3.micro"          
ingress_ports = [22, 80]            # SSH allowed for development

# ── staging.tfvars ─────────────────────────────────
vpc_cidr      = "10.1.0.0/16"      # different CIDR — no overlap with dev
subnet_cidr   = "10.1.1.0/24"
instance_type = "t3.small"          
ingress_ports = [22, 80, 443]       # HTTPS added for staging tests

# ── prod.tfvars ────────────────────────────────────
vpc_cidr      = "10.2.0.0/16"      # different CIDR — no overlap with dev/staging
subnet_cidr   = "10.2.1.0/24"
instance_type = "c7i-flex.large"    
ingress_ports = [80, 443]           # NO SSH in prod — security hardened
```

| Setting | `dev` | `staging` | `prod` |
|---------|-------|-----------|--------|
| `vpc_cidr` | `10.0.0.0/16` | `10.1.0.0/16` | `10.2.0.0/16` |
| `subnet_cidr` | `10.0.1.0/24` | `10.1.1.0/24` | `10.2.1.0/24` |
| `instance_type` | `t3.micro` | `t3.small` | `c7i-flex.large` |
| `ingress_ports` | `[22, 80]` | `[22, 80, 443]` | `[80, 443]` |
| SSH (port 22) |  Yes |  Yes |  No |
| HTTPS (port 443) |  No |  Yes |  Yes |

---

## TerraWeek Day-by-Day Concepts

| Day | Concepts |
|-----|----------|
| 61 | IaC, HCL, init/plan/apply/destroy, state basics |
| 62 | Providers, resources, dependencies, lifecycle |
| 63 | Variables, outputs, data sources, locals, functions |
| 64 | Remote backend, locking, import, drift |
| 65 | Custom modules, registry modules, versioning |
| 66 | EKS with modules, real-world provisioning |
| 67 | Workspaces, multi-env, capstone project |
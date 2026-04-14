# VPC
# Creates an isolated network in AWS
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "TerraWeek-VPC"
  }
}

# Public Subnet
# Public subnet inside the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "TerraWeek-Public-Subnet"
  }
}

# Internet Gateway
# Connects VPC to the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "TerraWeek-igw"
  }
}

# Route Table
# Routes traffic from subnet to IGW
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "TerraWeek-Public-RT"
  }
}

# Route Table Association
# Links subnet to the route table
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
# Firewall: allow SSH & HTTP, all outbound
resource "aws_security_group" "ec2-sg" {
  name        = "TerraWeek-SG"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "TerraWeek-SG"
  }
}

# EC2 Instance
# Launch a server in public subnet
resource "aws_instance" "ec2" {
  ami                         =  # ami-0cb5cf49019e79c51
  instance_type               = "t3.micro"
  key_name                    = "josh-batch"
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]

  tags = {
    "Name" = "TerraWeek-Server"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# S3 Bucket
# Stores app logs, depends on EC2
resource "aws_s3_bucket" "app_logs" {
  bucket     = "terraweek-app-logs-2k26"
  depends_on = [aws_instance.ec2]
  tags = {
    "Name" = "TerraWeek-app-logs"
  }
}
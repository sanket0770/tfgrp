terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Define provider (AWS)
provider "aws" {
  region = "eu-west-2"
  access_key = "AKIAX3LNWYOGIVRPHOXY"
  secret_key = "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"
}


resource "aws_security_group" "mysql_sg" {
  name        = "parallel-mysql-sg1"
  description = "Security group for MySQL on port 3306"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from any IP address
  }
}
output "security_group_id" {
  value = aws_security_group.mysql_sg.id
}
data "aws_security_group" "mysql_sg" {
  id = aws_security_group.mysql_sg.id
}

resource "aws_db_instance" "default" {
  allocated_storage             = 20
  apply_immediately             = true
  db_name                       = "mydb1"
  engine                        = "mysql"
  engine_version                = "5.7"
  identifier                    = "parallel-research-rds1"   
  instance_class                = "db.t3.micro"
  network_type                  = "IPV4"
  port                          = "3306" 
  publicly_accessible           = true
  username                      = "admin"
  password                      = "passwd1!"
  parameter_group_name          = "default.mysql5.7"
  vpc_security_group_ids        = [data.aws_security_group.mysql_sg.id]
}
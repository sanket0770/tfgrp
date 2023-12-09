terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
  access_key = "AKIAX3LNWYOGIVRPHOXY"
  secret_key = "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"
}

resource "aws_elastic_beanstalk_application" "my_app" {
  name = "parallel-research-ElasticBeanstalkApp"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "tf-test-version-label"
  application = aws_elastic_beanstalk_application.my_app.name
  description = "application version created by terraform"
  bucket      = "recipebook-app-bucket"
  key         = "Parallel.zip"
}

resource "aws_elastic_beanstalk_environment" "my_environment" {
  name        = "parallel-research-Environment"
  application = aws_elastic_beanstalk_application.my_app.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.6 running Python 3.11"
  version_label = aws_elastic_beanstalk_application_version.default.name

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PYTHONPATH"
    value     = "/opt/python/current/app:/opt/python/run/venv/lib/python3.8/site-packages"
  }
  
  setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "IamInstanceProfile"
      value     = "aws-elasticbeanstalk-ec2-role"
    }

}

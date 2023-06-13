provider "aws" {
  region = "us-east-1"
}

resource "aws_elastic_beanstalk_application" "my_app" {
  name        = "chet-port-test"
  description = "My portfolio test on Beanstalk"
}

resource "aws_elastic_beanstalk_environment" "my_environment" {
  name                = "docker-environment"
  application         = aws_elastic_beanstalk_application.my_app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.3 running Docker"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PARAM1"
    value     = "VALUE1"
  }
}

resource "aws_elastic_beanstalk_application_version" "my_app_version" {
  name        = "v-1"
  application = aws_elastic_beanstalk_application.my_app.name
  description = "This is the first version"

  source_bundle {
    bucket = aws_elastic_beanstalk_environment.my_environment.name
    key    = "docker-app.zip"
  source = "https://hub.docker.com/krazykrait/portfolio-1.0:latest"
}
}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }

  backend "s3" {
    bucket         = "tws-junoon-sqb-state-bucket"   # S3 bucket name
    key            = "terraform.tfstate"     # Path to the state file in the bucket
    region         = "us-east-2"                      # AWS region
    dynamodb_table = "tws-junoon-state-table"                # Optional: state locking using DynamoDB
  }
}

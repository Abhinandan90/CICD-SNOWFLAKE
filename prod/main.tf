terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.87"
    }
  }

  backend "s3" {
    bucket = "my-terraform-state-bucket-dataplatr"
    key    = "terraform-staging/tfstate"
    region = "us-east-1"
    # Optional DynamoDB for state locking. See https://developer.hashicorp.com/terraform/language/settings/backends/s3 for details.
    # dynamodb_table = "terraform-state-lock-table"
    encrypt = true
  }
}

provider "snowflake" {
  user              = "ABHI"
  account_name      = "FV23937"
  role              = "ACCOUNTADMIN"
  organization_name = "DRHKQLS"
  password          = "Jaihanuman02#3"
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = 30
  database            = var.database
  env_name            = var.env_name
}
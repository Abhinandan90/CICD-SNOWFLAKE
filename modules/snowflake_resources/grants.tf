resource "snowflake_account_role" "tf_demo_reader" {
  name = "TF_DEMO_READER"
}

resource "snowflake_database_role" "tf_demo_reader" {
  database = snowflake_database.tf_demo_database.name
  name     = "TF_DEMO_READER"
}

resource "snowflake_grant_privileges_to_database_role" "grant_usage_on_db" {
  database_role_name = snowflake_database_role.tf_demo_reader.fully_qualified_name
  on_database        = snowflake_database_role.tf_demo_reader.database
  privileges         = ["USAGE"]
}
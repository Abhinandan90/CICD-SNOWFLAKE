# Create Role
resource "snowflake_role" "tf_demo_reader" {
  name = "TF_DEMO_READER"
}

# Grant USAGE on the Database
resource "snowflake_grant_privileges_to_database_role" "grant_usage_on_db" {
  privileges         = ["USAGE"]
  database_role_name = snowflake_role.tf_demo_reader.name
  on_database        = snowflake_database.tf_demo_database.name
}

# Grant USAGE on the Schema
resource "snowflake_grant_privileges_to_database_role" "grant_usage_on_schema" {
  privileges         = ["USAGE"]
  database_role_name = snowflake_role.tf_demo_reader.name
  on_schema {
    schema_name = "${snowflake_database.tf_demo_database.name}.${snowflake_schema.tf_demo_schema.name}"
  }
}

# Grant SELECT on all future Tables
resource "snowflake_grant_privileges_to_database_role" "grant_select_on_future_tables" {
  privileges         = ["SELECT"]
  database_role_name = snowflake_role.tf_demo_reader.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = "${snowflake_database.tf_demo_database.name}.${snowflake_schema.tf_demo_schema.name}"
    }
  }
}

# Grant SELECT on all future Views
resource "snowflake_grant_privileges_to_database_role" "grant_select_on_future_views" {
  privileges         = ["SELECT"]
  database_role_name = snowflake_role.tf_demo_reader.name
  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = "${snowflake_database.tf_demo_database.name}.${snowflake_schema.tf_demo_schema.name}"
    }
  }
}
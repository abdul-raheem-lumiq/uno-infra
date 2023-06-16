resource "postgresql_database" "postgresDB" {
  provider = "postgresql.postgres1"
  name              = "_DBNAME_"
  connection_limit  = -1
}
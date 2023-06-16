terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.19.0"
    }
  }
}

provider "postgresql" {
  alias           = "postgres1"
  scheme          = "awspostgres"
  host            = "_HOST_"
  port            = _PORT_
  database        = "_DATABASE_"
  username        = "_USERNAME_"
  password        = "_PASSWORD_"
  #sslmode         = "disable"
  #connect_timeout = 60
}
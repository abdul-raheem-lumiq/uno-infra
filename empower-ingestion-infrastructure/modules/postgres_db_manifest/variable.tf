variable alias {
  type        = string
  default     = ""
  description = "Alias for postgresDB"
}
variable host {
  type        = string
  default     = ""
  description = "Host for postgresDB"
}
variable port {
  default     = ""
  description = "Port for postgresDB"
}
variable database {
  type        = string
  default     = ""
  description = "Connection DB for postgres"
}
variable username {
  type        = string
  default     = ""
  description = "Connection user for postgres"
}
variable password {
  type        = string
  default     = ""
  description = "Connection user password for postgres"
}
variable sslmode {
  type        = string
  default     = "disable"
  description = "SSL required or not"
}
variable connect_timeout {
  default     = 60
  description = "Connection timeout duration"
}
variable db_name {
  type        = string
  default     = ""
  description = "name of database to be created"
}
variable connection_limit {
  default     = -1
  description = "Connection limit on DB"
}



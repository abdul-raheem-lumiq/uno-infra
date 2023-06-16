variable "identifier" {
}
variable "storage" {
    default = 50
}
variable "instance_class" {
    default = "db.t3.medium"
}
variable "engine" {
    default = "postgres"
}
variable "username" {
}
variable "password" {
}
variable "db_name" {
    default = "master"
}
variable "backup_window" {
    default = "17:56-18:26"
}
variable "backup_retention_period" {
    default = 0
}
variable "maintainace_window" {
    default = "thu:11:19-thu:11:49"
}
variable "multi_az" {
    default = false
}
variable "publicly_accessible" {
    default = false
}
variable "auto_minor_version_upgrade" {
    default = false
}
variable "storage_type" {
    default = "gp2"
}
variable "port" {
    default = 25432
}
variable "storage_encrypted" {
    default = true
}
variable "monitoring_interval" {
    default = 0
}
variable "iam_database_authentication_enabled" {
    default = false
}
variable "deletion_protection" {
    default = true
}
variable "db_subnet_group_name" {
}
variable "db_subnet_ids" {
    description = "[aws_subnet.frontend.id, aws_subnet.backend.id]"
}
variable "vpc_id" {
    default = "vpc-0eb01e89554906a06"
}
variable "engine_version" {
    default = "14.4"
}
variable "sg_name" {
}
variable "skip_final_snapshot" {
    default = true
}
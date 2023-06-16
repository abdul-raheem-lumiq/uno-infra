output "address" {
    value = aws_db_instance.RDSDBInstance.address
}
output "port" {
    value = aws_db_instance.RDSDBInstance.port
}
output "username" {
    value = aws_db_instance.RDSDBInstance.username
}
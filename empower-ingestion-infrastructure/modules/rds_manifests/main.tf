resource "aws_db_instance" "RDSDBInstance" {
    identifier = var.identifier
    allocated_storage = var.storage
    instance_class = var.instance_class
    engine = var.engine
    username = var.username
    password = var.password
    name = var.db_name
    backup_window = var.backup_window
    backup_retention_period = 0
    skip_final_snapshot = var.skip_final_snapshot
    maintenance_window = var.maintainace_window
    multi_az = var.multi_az
    engine_version = var.engine_version
    auto_minor_version_upgrade = var.auto_minor_version_upgrade
    publicly_accessible = var.publicly_accessible
    storage_type = var.storage_type
    port = var.port
    storage_encrypted = var.storage_encrypted
    #kms_key_id = 
    copy_tags_to_snapshot = true
    monitoring_interval = var.monitoring_interval
    iam_database_authentication_enabled = var.iam_database_authentication_enabled
    deletion_protection = var.deletion_protection
    db_subnet_group_name = aws_db_subnet_group.DBSubnetGroup.name
    vpc_security_group_ids = [
        aws_security_group.EC2SecurityGroup.id 
    ]
    tags = {
    Project = "empower-foundation-ingestion"
  }
}

resource "aws_db_subnet_group" "DBSubnetGroup" {
  name       = var.db_subnet_group_name
  subnet_ids = var.db_subnet_ids

  tags = {
    Project = "empower-foundation-ingestion"
  }
}

resource "aws_security_group" "EC2SecurityGroup" {
    description = "launch-wizard-10 created 2022-01-18T12:41:38.302+05:30"
    name = var.sg_name
    vpc_id = var.vpc_id
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 25432
        protocol = "tcp"
        to_port = 25432
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
    tags = {
    Name = "empower-foundation-ingestion-rds-sg",
    Project = "empower-foundation-ingestion"
  }
}
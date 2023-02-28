# resource "aws_db_subnet_group" "rds_subnet_groups" {
#   name       = "db-subnet-groups"
#   subnet_ids = [
#     for subnet in aws_subnet.private_subnet: subnet.id
#     ]
#   tags = {
#     Name = "DB subnet group for dev"
#   }
# }

# resource "aws_db_instance" "rds-fpsouza-dev" {
#   allocated_storage      = var.rds_settings.database.allocated_storage
#   identifier             = var.rds_settings.database.identifier
#   engine                 = var.rds_settings.database.engine
#   engine_version         = var.rds_settings.database.engine_version
#   instance_class         = var.rds_settings.database.instance_class
#   username               = var.rds_settings.database.username
#   password               = var.rds_settings.database.password
#   db_subnet_group_name   = aws_db_subnet_group.rds_subnet_groups.name
#   vpc_security_group_ids = [aws_security_group.rds_sg.id]
#   skip_final_snapshot    = true
# }

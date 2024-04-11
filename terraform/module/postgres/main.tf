module "postgres" {
    source = "terraform-aws-modules/rds-aurora/aws"

    vpc_id            = var.vpc_id
    engine_version    = var.engine_version
    instance_class    = var.instance_class
    allocated_storage = var.allocated_storage

    vpc_security_group_ids = [aws_security_group.example.id]

}

resource "aws_security_group_rule" "postgres_ingress" {
    security_group_id = module.postgres.security_group_id
    type              = "ingress"
    from_port         = 5432
    to_port           = 5432
    protocol          = "tcp"
    cidr_blocks       = [var.vpc_cidr_block]
}

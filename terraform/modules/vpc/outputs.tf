output "vpc_id"            { value = aws_vpc.this.id }
output "public_subnet_ids" { value = aws_subnet.public[*].id }
output "k8s_sg_id"         { value = aws_security_group.k8s_nodes.id }

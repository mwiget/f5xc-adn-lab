output "aws_vpc" {
  value = aws_vpc.vpc.id
}
output "aws_subnet" {
  value = aws_subnet.subnet
}
output "aws_route_table" {
  value = aws_route_table.rt
}
output "aws_route_table_association" {
  value = aws_route_table_association.rta
}

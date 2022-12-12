output "aws_east" {
  value = module.aws_east
}
output "aws_west" {
  value = module.aws_west
}
output "aks" {
  value = module.aks
  sensitive = true
}

output "aws_us_east_2" {
  value = module.aws_us_east_2
}
output "aws_us_west_2" {
  value = module.aws_us_west_2
}
output "aws_eu_north_1" {
  value = module.aws_eu_north_1
}
output "aws_eu_west_1" {
  value = module.aws_eu_west_1
}
output "aks" {
  value = module.aks
  sensitive = true
}

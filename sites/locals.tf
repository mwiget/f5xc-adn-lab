locals {
  subnets_us_east_2 = jsondecode(file("../infra/subnets_us_east_2.json"))
  subnets_us_west_2 = jsondecode(file("../infra/subnets_us_west_2.json"))
}

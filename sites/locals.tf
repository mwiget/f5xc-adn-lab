locals {
  subnets_us_east_2  = jsondecode(file("../infra/subnets_us_east_2.json"))
  subnets_us_west_2  = jsondecode(file("../infra/subnets_us_west_2.json"))
  subnets_eu_north_1 = jsondecode(file("../infra/subnets_eu_north_1.json"))
  subnets_eu_west_1  = jsondecode(file("../infra/subnets_eu_west_1.json"))
}

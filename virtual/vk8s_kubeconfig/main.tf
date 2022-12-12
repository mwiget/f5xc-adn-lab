resource "null_resource" "check_vk8s_status" {
  triggers = {
    file_missing = fileexists(var.filename) ? "no" : local.random_id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/query.sh %s %s %s %s %s", path.module, var.f5xc_api_url, var.f5xc_api_token, var.f5xc_vk8s_namespace, var.f5xc_vk8s_name, var.filename)
    interpreter = ["/usr/bin/env", "bash", "-c"]
  }
}

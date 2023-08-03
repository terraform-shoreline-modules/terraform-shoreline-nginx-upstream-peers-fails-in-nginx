resource "shoreline_notebook" "nginx_upstream_peers_fails" {
  name       = "nginx_upstream_peers_fails"
  data       = file("${path.module}/data/nginx_upstream_peers_fails.json")
  depends_on = [shoreline_action.invoke_nginxbak_config_update]
}

resource "shoreline_file" "nginxbak_config_update" {
  name             = "nginxbak_config_update"
  input_file       = "${path.module}/data/nginxbak_config_update.sh"
  md5              = filemd5("${path.module}/data/nginxbak_config_update.sh")
  description      = "Optimize the NGINX configuration to ensure optimal performance and reduce the likelihood of upstream peer failures."
  destination_path = "/agent/scripts/nginxbak_config_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_nginxbak_config_update" {
  name        = "invoke_nginxbak_config_update"
  description = "Optimize the NGINX configuration to ensure optimal performance and reduce the likelihood of upstream peer failures."
  command     = "`chmod +x /agent/scripts/nginxbak_config_update.sh && /agent/scripts/nginxbak_config_update.sh`"
  params      = []
  file_deps   = ["nginxbak_config_update"]
  enabled     = true
  depends_on  = [shoreline_file.nginxbak_config_update]
}


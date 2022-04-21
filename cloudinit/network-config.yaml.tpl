write_files:
  - encoding: base64
    content: ${network_config_content_base64}
    path: /etc/netplan/50-cloud-init.yaml

runcmd:
  - netplan apply
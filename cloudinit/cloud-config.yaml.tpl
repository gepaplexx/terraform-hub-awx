#cloud-config
users:
  - name: ansible
    ssh-authorized-keys:
      - ${authorized_key}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash

${network_config}
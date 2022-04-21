network:
  version: 2
  ethernets:
    ens192:
      dhcp4: false
      addresses:
        -  ${network}/${netmask}
      gateway4: ${gateway}
      nameservers:
        addresses:
          - ${dns}
          - 8.8.8.8
        # search:
        #   - mycompany.com
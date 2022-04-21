/*resource "vsphere_host_port_group" "pg" {
  count               = "${length(var.vmware_esxi_hosts)}"
  name                = "${var.hub_network_name}"
  host_system_id      = "${data.vsphere_host.host[count.index].id}"
  virtual_switch_name = "${var.hub_vswitch}"
  vlan_id             = "${var.hub_vlan_id}"
}*/

/* Wird mit DNS erstellt
resource "vsphere_folder" "folder" {
  path = "GP/${var.hub_network_name}"
  type = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [vsphere_folder.folder] # [vsphere_host_port_group.pg,vsphere_folder.folder]
  create_duration = "30s"
}*/

resource vsphere_virtual_machine "awx" {
  count           = var.awx_vm_count
  name             = "gp-central-awx${count.index}"
  resource_pool_id = data.vsphere_compute_cluster.cc.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id
  folder           = "GP/${var.hub_network_name}"

  num_cpus  = var.awx_vm_cpu
  memory    = var.awx_vm_memory_mb
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  cdrom {
    client_device = true
  }

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    use_static_mac = "true"
    mac_address = "${var.hub_mac_prefix}:0${count.index + 4}"
  }
  wait_for_guest_net_timeout = 0

  disk {
    label            = "disk0"
    size             = var.awx_disk_size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  vapp {
    properties ={
      hostname = "gp-central-awx${count.index}"
      user-data = base64encode(templatefile("${path.module}/cloudinit/cloud-config.yaml.tpl", {
        authorized_key = var.authorized_key
        network_config = templatefile("${path.module}/cloudinit/network-config.yaml.tpl", {
          network_config_content_base64 = base64encode(templatefile("${path.module}/cloudinit/network-config-content.yaml.tpl", {
            dns     = "${var.hub_network}.1"
            gateway = "${var.hub_network}.254"
            netmask = var.hub_netmask
            network = "${var.hub_network}.${count.index + 2}"
          }))
        })
      }))
    }
  }
}
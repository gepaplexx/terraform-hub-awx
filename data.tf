data vsphere_datacenter "dc" {
  name = "${var.vmware_datacenter}"
}

/*
data vsphere_host "host" {
  count         = "${length(var.vmware_esxi_hosts)}"
  name          = "${var.vmware_esxi_hosts[count.index]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
*/

data vsphere_compute_cluster "cc" {
  name          = "${var.vmware_computecluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data vsphere_datastore "ds" {
  name          = "${var.vmware_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data vsphere_network "network" {
  name          = "GP_central_2026"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data vsphere_virtual_machine "template" {
  name          = "${var.vmware_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
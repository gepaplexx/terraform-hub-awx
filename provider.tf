# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "${var.vmware_user}"
  password       = "${var.vmware_password}"
  vsphere_server = "${var.vmware_host}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}
variable "authorized_key" {
  type = string
  description = "authorized key used to log in to all vms in the hub network."
}

###############################
# Hub network configuration #
###############################

variable "hub_mac_prefix" {
  type = string
  description = "MAC address prefix used for each vm in the spoke network."
}

variable "hub_network_name" {
  type = string
  description = "Name of the network."
}

/*variable "hub_vlan_id" {
  type = number
  description = "Specify the vlan id associated to the network."
}

variable "hub_vswitch" {
  type = string
  description = "Specify the vswitch the network should be attached to."
}*/

########################
# vmware configuration #
########################

variable "vmware_host" {
  type = string
  description = "The vsphere host name or ip used for authentication."
}
variable "vmware_user" {
  type = string
  description = "The vsphere user used for authentication."
}

variable "vmware_password" {
  type = string
  description = "The vsphere passwordused for authentication."
}

/*variable "vmware_esxi_hosts" {
  type = list(string)
  description = "The vsphere esx host names."
}*/

variable "vmware_datacenter" {
  type = string
  description = "The vsphere datacenter name."
}

variable "vmware_computecluster" {
  type = string
  description = "The vsphere computecluster name."
}

variable "vmware_datastore" {
  type = string
  description = "The vsphere datastore name."
}

variable "vmware_template" {
  type = string
  description = "The vsphere vm template used to provision new vms."
}

#############################
# VM resource configuration #
#############################

variable "awx_vm_count" {
  type = number
  validation {
    condition     = can(regex("1|3|5|7", var.awx_vm_count))
    error_message = "Valid values for var: ocp_master_count are (1,3,5,7)."
  }
  description = "Specify the number of vms (valid values are 1,3,5,7)."
}

variable "awx_vm_cpu" {
  type = number
  description = "Specify the cpu for service vms."
}

variable "awx_disk_size" {
  type = number
  description = "Specify the cpu for service vms."
}

variable "awx_vm_memory_mb" {
  type = number
  description = "Specify the ram in MB for service vms."
}
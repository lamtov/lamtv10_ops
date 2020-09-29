Tập yêu cầu:
- VIM support upgrade and rollback, pre-package releases with orchestrated upgrade and rollback
	

- VIM shall be able to do backup and restore services covers for infrastructure 


- VIM shall support to deploy undercloud and controller on dedicated physical compute/server 






- VIM shall support expansion of capacity by adding more NFVI servers easily with GUI tool 


- NFV servers must be configured with CPU isolation for the host and shall be configurable during the installation 


- VIM shall support different options for server setup such as SR-IOV and OVS-DPDK and shall be able to easily select via GUI during installation or during adding servers.




https://docs.openstack.org/tripleo-docs/latest/install/introduction/components.html

https://docs.openstack.org/tripleo-docs/latest/install/introduction/components.html#node-management
- Installation GUI must include support for different HW flavors.

Node Management¶
ironic¶
Ironic project is responsible for provisioning and managing bare metal instances.
ironic inspector (former ironic-discoverd)¶
Ironic Inspector project is responsible for inspection of hardware properties for newly enrolled nodes (see also ironic).
VirtualBMC¶
A helper command to translate IPMI calls into libvirt calls. Used for testing bare metal provisioning on virtual environments.


heat¶
Heat is OpenStack’s orchestration tool. It reads YAML files describing the OpenStack deployment’s resources (machines, their configurations etc.) and gets those resources into the desired state, often by talking to other components (e.g. Nova).


- VIM shall check and validate that the existing infrastructure supports the specific requirements of the VNF such as compute resources, SR-IOV/DPDK/Huge pages requirement prior to VNF installation 

	+ validate-ipmi
	+ validate-simple
	+ validate-ui

tripleo-validations¶
Pre and post-deployment validations for the deployment workflow.

prep validations check the hardware configuration of the Undercloud node and should be run before openstack undercloud install. Running prep validations should not rely on Mistral because it might not be installed yet.

pre-introspection should be run before we introspect nodes using Ironic Inspector.

pre-deployment validations should be executed before openstack overcloud deploy




- Update:
https://docs.openstack.org/tripleo-docs/latest/upgrade/developer/upgrades/minor_update.html#how-update-commands-work




TripleO:
- TripleO-image-elements: Disk image elements for deployment images of Openstack
- tripleO-ci: CI for TripleO project: execute job on CI slave nodes (Jenkins slaves)
- tripleO-quickstart-extras
	role:
	+ baremetal-prep-overcloud
	+ baremetal-undercloud
	+ build-images
	+ build-test-packages
	+ container-update
	+ overcloud-delete
	+ overcloud-deploy
	+ overcloud-prep-config
	+ overcloud-prep-containers
	+ overcloud-prep-flavors
	+ overcloud-prep-images
	+ overcloud-prep-network
	+ overcloud-scale
	+ overcloud-ssl
	+ set-libvirt-type
	+ snapshot-libvirt
	+ standalone-upgrade
	+ tripleo-validations
	+ undercloud-deploy
	+ undercloud-setup
	+ validate-ipmi
	+ validate-simple
	+ validate-ui
	+
	+
	+
	+
	+
	+
	+
	+



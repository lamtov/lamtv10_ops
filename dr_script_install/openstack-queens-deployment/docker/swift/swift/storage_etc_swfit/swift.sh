systemctl enable openstack-swift-account.service openstack-swift-account-auditor.service openstack-swift-account-reaper.service openstack-swift-account-replicator.service
systemctl start openstack-swift-account.service openstack-swift-account-auditor.service  openstack-swift-account-reaper.service openstack-swift-account-replicator.service
systemctl enable openstack-swift-container.service  openstack-swift-container-auditor.service openstack-swift-container-replicator.service openstack-swift-container-updater.service
 systemctl start  openstack-swift-container.service   openstack-swift-container-auditor.service openstack-swift-container-replicator.service openstack-swift-container-updater.service
systemctl enable openstack-swift-object.service openstack-swift-object-auditor.service   openstack-swift-object-replicator.service openstack-swift-object-updater.service
 systemctl start  openstack-swift-object.service openstack-swift-object-auditor.service   openstack-swift-object-replicator.service openstack-swift-object-updater.service


swift-ring-builder account.builder create 10 1 1
 swift-ring-builder account.builder add --region 1 --zone 1 --ip 172.16.30.172  --port 6202 --device vdc --weight 100
 swift-ring-builder account.builder
 swift-ring-builder account.builder rebalance

swift-ring-builder container.builder create 10 1 1
swift-ring-builder container.builder add --region 1 --zone 1 --ip 172.16.30.172 --port 6201 --device vdc --weight 100
swift-ring-builder container.builder
swift-ring-builder container.builder rebalance


 swift-ring-builder object.builder create 10 1 1
  swift-ring-builder object.builder add --region 1 --zone 1 --ip  172.16.30.172 --port 6200  --device vdc --weight 100
swift-ring-builder object.builder
 swift-ring-builder object.builder rebalance

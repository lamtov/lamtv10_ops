Sửa lỗi osprofiler không có cấu hình always enable:

curl -v -g -i -X POST https://os.controller:8774/v2.1/servers/42ed5848-0338-4b06-8cbc-7b9d228080b8/action -H "User-Agent: Apache-HttpClient/4.5.6" -H "Content-Type: application/json" -H "Accept: application/json" -H "X-Auth-Token: gAAAAABdpaS4dUtTkgzqBpmILt2LH1na-uz5BZtAP3K8wzJFAYXLIxA0Mf4KptPwS_fKOTrZrDd3lV7TpadirGB7xrhw91mdJndTD0crr_IxIjKIwZzsTyfLm7Tvgk2EKkdSb8tB5poYE3_qwcXianAquqTjLfjnmaMOkVgS5Tny5wBgEXuov3c" -d '{"os-migrateLive": {"disk_over_commit": false, "block_migration": false, "host": "SPGM01DRCOMP7"}}'


curl -g -i -X GET https://os.controller:8774/v2.1/flavors/detail -H "User-Agent: python-novaclient" -H "Accept: application/json" -H "X-Auth-Token: gAAAAABdwPt-zqVEdkBJilGSxtXJYcukwYckv6Snr_inBI0RTzr4HGt0q3hWpVuMzmcn4S3RfNjeFog1_ojWwVnfGSF3ZpyPoLH1FAhai6PvJkUC0S2z6TefVlqZcTF4yMEVV_cAcSW3PlazRgyuhhlnYxWjZbT8pRaZIOlTWRT6YZuuMc5ezEc" -H "X-Openstack-Request-Id: req-3dccb8c4-08fe-4706-a91d-e843b8fe9ed2"



  990  openstack --debug server list
  991  source ~/vocsrc
  992  openstack --debug server list
  993  openstack token issue
  994  curl -g -i -X GET https://os.controller:8774/v2.1/flavors/detail -H "User-Agent: python-novaclient" -H "Accept: application/json" -H "X-Auth-Token: gAAAAABdwPt-zqVEdkBJilGSxtXJYcukwYckv6Snr_inBI0RTzr4HGt0q3hWpVuMzmcn4S3RfNjeFog1_ojWwVnfGSF3ZpyPoLH1FAhai6PvJkUC0S2z6TefVlqZcTF4yMEVV_cAcSW3PlazRgyuhhlnYxWjZbT8pRaZIOlTWRT6YZuuMc5ezEc" -H "X-Openstack-Request-Id: req-3dccb8c4-08fe-4706-a91d-e843b8fe9ed2"
  995  curl -g -i -X GET https://os.controller:8774/v2.1/flavors/detail -H "User-Agent: python-novaclient" -H "Accept: application/json" -H "X-Auth-Token: gAAAAABdwPt-zqVEdkBJilGSxtXJYcukwYckv6Snr_inBI0RTzr4HGt0q3hWpVuMzmcn4S3RfNjeFog1_ojWwVnfGSF3ZpyPoLH1FAhai6PvJkUC0S2z6TefVlqZcTF4yMEVV_cAcSW3PlazRgyuhhlnYxWjZbT8pRaZIOlTWRT6YZuuMc5ezEc" -H "X-Openstack-Requesttttttttt-Id: req-3dccb8c4-08fe-4706-a91d-e843b8fe9ed2"
  996  curl -g -i -X GET https://os.controller:8774/v2.1/flavors/detail -H "User-Agent: python-novaclient" -H "Accept: application/json" -H "X-Auth-Token: gAAAAABdwPt-zqVEdkBJilGSxtXJYcukwYckv6Snr_inBI0RTzr4HGt0q3hWpVuMzmcn4S3RfNjeFog1_ojWwVnfGSF3ZpyPoLH1FAhai6PvJkUC0S2z6TefVlqZcTF4yMEVV_cAcSW3PlazRgyuhhlnYxWjZbT8pRaZIOlTWRT6YZuuMc"
  997  curl -g -i -X GET https://os.controller:8774/v2.1/flavors/detail -H "User-Agent: python-novaclient" -H "Accept: application/json" -H "X-Auth-Token: gAAAAABdwPt-zqVEdkBJilGSxtXJYcukwYckv6Snr_inBI0RTzr4HGt0q3hWpVuMzmcn4S3RfNjeFog1_ojWwVnfGSF3ZpyPoLH1FAhai6PvJkUC0S2z6TefVlqZcTF4yMEVV_cAcSW3PlazRgyuhhlnYxWjZbT8pRaZIOlTWRT6YZuuMc5ezEc"
  998  history
ll



 curl -g -i -X GET "https://os.controller:9292/v2/images?marker=48d00dc6-eecf-42d6-900f-c27028a51f19" -H "User-Agent: osc-lib/1.9.0 keystoneauth1/3.4.0 python-requests/2.14.2 CPython/2.7.5" -H "X-Auth-Token: gAAAAABdwqdJ8LahxYojHNJvsZ_kHNSjS6yIskThqV1ruF9WmloNKxRCeFKHwRB2CFSxQHtBBMYuWGIVLLcwKFNlcnWJTy_JxiuvHe_pui_6RNUkuluC-tDBCeD2RqT8GU4eCPFwQSZsEYAXI8jnQTG2cmIiX83-t2gNEUhjEK7DkdwhFLFhwC8" -H "X-Openstack-Request-Id: req-3dccb8c4-08fe-4706-a91d-e843b8fe9ed2"



curl -g -i -X GET https://os.controller:8774/v2.1/flavors/detail -H "User-Agent: python-novaclient" -H "Accept: application/json" -H "X-Auth-Token: gAAAAABdwqdJ8LahxYojHNJvsZ_kHNSjS6yIskThqV1ruF9WmloNKxRCeFKHwRB2CFSxQHtBBMYuWGIVLLcwKFNlcnWJTy_JxiuvHe_pui_6RNUkuluC-tDBCeD2RqT8GU4eCPFwQSZsEYAXI8jnQTG2cmIiX83-t2gNEUhjEK7DkdwhFLFhwC8" -H "X-Openstack-Request-Id: req-3dccb8c4-08fe-4706-a91d-e843b8fe9ed2"

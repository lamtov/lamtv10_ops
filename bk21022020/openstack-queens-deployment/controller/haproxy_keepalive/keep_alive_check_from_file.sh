global_defs {
   router_id LVS_DEVEL
   #enable_script_security
   script_user root
}



vrrp_script check_haproxy {
   script "pkill -0 haproxy"
   interval 2
   #weight 2

}

vrrp_script check_mysqld {
  script "pkill -0 mysqld"
  interval 1
  #weight 2
}



vrrp_script check_mysqld_script {
  script "/usr/local/bin/check_mysql.sh"
   #script "/usr/local/bin/mongo.sh"
  interval 2
  #weight 2
}



vrrp_script check_ping {
   script "timeout 2 ping -c 3 -i 0.5 172.16.31.247"
        interval 10
        rise 2
}


vrrp_sync_group VG_1 {
   group {
      PRIVATE_V1
   }
}




vrrp_instance PRIVATE_V1 {
   state BACKUP
   priority 100
   advert_int 1
   nopreempt
   garp_master_delay 0
   dont_track_primary


   interface ens192

   virtual_router_id 49
                                                   
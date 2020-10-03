
nova boot --flavor 8C16R20G_H1G --nic net-id=99acf64a-c858-4378-8816-99b01c80aa84 --key-name vocs --image 70b61e10-601a-4a32-8a03-80971719f5c5 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=1 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=2 --availability-zone nova:SPGM01DRCOMP1  tl1

nova boot --flavor 8C16R20G_H1G --nic net-id=99acf64a-c858-4378-8816-99b01c80aa84 --key-name vocs --image 70b61e10-601a-4a32-8a03-80971719f5c5 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=1 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=2 --availability-zone nova:SPGM01DRCOMP2  tl2
nova boot --flavor 8C16R20G_H1G --nic net-id=99acf64a-c858-4378-8816-99b01c80aa84 --key-name vocs --image 70b61e10-601a-4a32-8a03-80971719f5c5 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=1 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=2 --availability-zone nova:SPGM01DRCOMP3  tl3
nova boot --flavor 8C16R20G_H1G --nic net-id=99acf64a-c858-4378-8816-99b01c80aa84 --key-name vocs --image 70b61e10-601a-4a32-8a03-80971719f5c5 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=1 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=2 --availability-zone nova:SPGM01DRCOMP1  tl4

nova boot --flavor 8C16R20G_H1G --nic net-id=99acf64a-c858-4378-8816-99b01c80aa84 --key-name vocs --image 70b61e10-601a-4a32-8a03-80971719f5c5 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=1 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=2 --availability-zone nova:SPGM01DRCOMP2  tl5

nova boot --flavor 8C16R20G_H1G --nic net-id=99acf64a-c858-4378-8816-99b01c80aa84 --key-name vocs --image 70b61e10-601a-4a32-8a03-80971719f5c5 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=1 --block-device source=blank,dest=volume,size=100,shutdown=preserve,bootindex=2 --availability-zone nova:SPGM01DRCOMP3  tl6


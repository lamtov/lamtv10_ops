<?xml version="1.0" encoding="UTF-8"?>
<MonitorClient>
<!--LastUpdate Sat Sep 28 15:54:40 ICT 2019-->
        <Client>
                <Name>cinder-api</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh cinder-api cinder-api</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>cinder-scheduler</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh cinder-scheduler cinder-scheduler</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>cinder-volume</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh cinder-volume cinder-volume</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>docker</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>service</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <Pid>systemctl show -p MainPID docker | cut -d= -f2</Pid>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>glance-api</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh glance-api glance-api</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>glance-registry</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh glance-registry glance-registry</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>haproxy</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>service</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <Pid>systemctl show -p MainPID haproxy | cut -d= -f2</Pid>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>horizon</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh horizon horizon</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>keepalived</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>service</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <Pid>systemctl show -p MainPID keepalived | cut -d= -f2</Pid>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>keystone</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh keystone keystone</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>libvirtd</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>service</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <Pid>systemctl show -p MainPID libvirtd | cut -d= -f2</Pid>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>memcached</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>service</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <Pid>systemctl show -p MainPID memcached | cut -d= -f2</Pid>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>neutron-server</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh neutron-server neutron-server</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>nova-api</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh nova-api nova-api</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>nova-conductor</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh nova-conductor nova-conductor</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>nova-consoleauth</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh nova-consoleauth nova-consoleauth</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>nova-novncproxy</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh nova-novncproxy nova-novncproxy</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>nova-placement-api</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh nova-placement-api nova-placement-api</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>nova-scheduler</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>container</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <State>/u01/oam/oam-agent/etc/check_docker_status.sh nova-scheduler nova-scheduler</State>
                        </Bin>
                </Folder>
        </Client>

        <Client>
                <Name>rabbitmq-server</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>service</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <Pid>systemctl show -p MainPID rabbitmq-server | cut -d= -f2</Pid>
                        </Bin>
                </Folder>
        </Client>


        <Client>
                <Name>httpd24-httpd</Name>
                <ApplicationType>Service</ApplicationType>
                <Is_Running_With_Wrapper>false</Is_Running_With_Wrapper>
                <Is_Check_Alive>true</Is_Check_Alive>
                <Is_Idle_When_Standby>false</Is_Idle_When_Standby>
                <Is_SwitchHA_After_RetryRestart>false</Is_SwitchHA_After_RetryRestart>
                <Retry_Restart>3</Retry_Restart>
                <Time_Restart>60000</Time_Restart>
                <Delay_Time_Before_Restart>2000</Delay_Time_Before_Restart>
                <Serivce_Cloud>service</Serivce_Cloud>
                <Folder>
                        <Bin>
                                <Pid>systemctl show -p MainPID httpd24-httpd | cut -d= -f2</Pid>
                        </Bin>
                </Folder>
        </Client>


</MonitorClient>[
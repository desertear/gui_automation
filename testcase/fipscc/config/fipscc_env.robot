*** Settings ***
Documentation     This file contains environment variables for FIPSCC

*** Variables ***
##FGT common configuration
${FGT_VLAN10_INTERFACE}    port3
${FGT_VLAN20_INTERFACE}    port2
${FGT_VLAN30_INTERFACE}    port1
${GENERAL_SERVER}    172.16.200.55
${FGT_VLAN10_IP}    10.6.30.1
${FGT_VLAN10_IP_V6}    2000:10:6:30::1
${FGT_VLAN30_IP}    172.16.200.1
${FGT_VLAN30_IP_V6}    2000:172:16:200::1
${FGT_VLAN20_IP}    10.1.100.1
${FGT_VLAN20_IP_V6}    2000:10:1:100::1
${FGT_VLAN30_GATEWAY}    172.16.200.254
${FGT_VLAN30_GATEWAY_V6}    2000:172:16:200::254

#the name of certificate that HTTPS uses.
${FGT_HTTPS_CERTIFICATE_NAME}    fgt_gui_automation
${FGT_PKI_PEER_CA_NAME}    pkica

#Timeout for FIPSCC cases running
${FIPSCC_MAX_RUNNING_TIME}    5 min

##Globale variables for FIPSCC GUI
${FIPSCC_CLI_FILE_DIR}    ${CURDIR}${/}cli
${FIPSCC_TIME_TOLERANCE}    10
${JS_WAITING_TIME}    2

#VDOM Setup
${FIPSCC_TEST_VDOM_NAME_root}    root
${FIPSCC_TEST_VDOM_NAME_1}    vdom1
${FIPSCC_TEST_VDOM_NAME_2}    vdom2
${FIPSCC_TEST_VDOM_NAME_TP}    vdom3
${FIPSCC_TP_MANAGE_IP}    172.16.201.1

##Variables for Policy Feature
#Service Variable
${FIPSCC_TEST_SERVICE_ALL}    ALL
${FIPSCC_TEST_SERVICE_1}    robot!service.1
${FIPSCC_TEST_SERVICE_2}    ip+service: 2
${FIPSCC_TEST_SERVICE_3}    w_source_port service-3
${FIPSCC_TEST_SERVICE_4}    icmp6~service% 4
${FIPSCC_TEST_SERVICE_5}    icmp&service$ * 5
${FIPSCC_TEST_SERVICE_GROUP_1}    srv:group.two service1
${FIPSCC_TEST_SERVICE_GROUP_2}    srv%!group,in=group 2
${FIPSCC_TEST_SERVICE_GROUP_3}    srv[group]one*member 3
#Address and Address Group Variable
#ipv4
${FIPSCC_TEST_ADDR_ALL}    all
${FIPSCC_TEST_ADDR_1}    robot!iprange$addr% 1    #created using iprange
${FIPSCC_TEST_ADDR_2}    robot_geo-addr= 2    #created using geo address
${FIPSCC_TEST_ADDR_3}    robot/fqdn,addr= 3    #created using fqdn
${FIPSCC_TEST_ADDR_4}    robot:sunet.addr= 4    #created using ipmask
${FIPSCCTEST_ADDR_GROUP_1}    robot&addr@group 1    #FIPSCC_TEST_ADDR_1 and FIPSCC_TEST_ADDR_2
${FIPSCC_TEST_ADDR_GROUP_2}    robot.addr:group 2    #FIPSCC_TEST_ADDR_GROUP_1 and FIPSCC_TEST_ADDR_3
${FIPSCC_TEST_ADDR_GROUP_3}    robot!addr~group 3    #FIPSCC_TEST_ADDR_4
#ipv6
${FIPSCC_TEST_ADDR6_ALL}    all
${FIPSCC_TEST_ADDR6_TEMPLATE_1}    robot&addr6*template_1
${FIPSCC_TEST_ADDR6_TEMPLATE_2}    robot[addr6]template 2
${FIPSCC_TEST_ADDR6_1}    robot!subnet$addr6% 1    #creted using subnet
${FIPSCC_TEST_ADDR6_2}    robot_template2-addr6= 2    #created using template2
${FIPSCC_TEST_ADDR6_3}    robot/fqdn,addr6= 3    #created using fqdn
${FIPSCC_TEST_ADDR6_4}    robot:fqdn addr6= 4    #created using iprange
${FIPSCC_TEST_ADDR6_GROUP_1}    robot&addr6@group 1    #FIPSCC_TEST_ADDR6_1 and FIPSCC_TEST_ADDR6_2
${FIPSCC_TEST_ADDR6_GROUP_2}    robot.addr6:group 2    #FIPSCC_TEST_ADDR6_GROUP_1 and FIPSCC_TEST_ADDR6_3
${FIPSCC_TEST_ADDR6_GROUP_3}    robot_addr6 group 3    #FIPSCC_TEST_ADDR6_4
#multicast
${FIPSCC_TEST_MULTICAST_ADDR_ALL}    all
#Wildcard FQDN Address
${FIPSCC_TEST_ADDRESS_W_FQDN_DROPBOX}    wildcard.dropbox.com
${FIPSCC_TEST_ADDRESS_W_FQDN_GOOGLE}    wildcard.google.com
${FIPSCC_TEST_ADDRESS_W_FQDN_GROUP1}    addr*w& c=a-r_d+g=r!oup.1
${FIPSCC_TEST_ADDRESS_W_FQDN_GROUP2}    addr:w;c[a]r@d-group+2

${FIPSCC_TEST_W_FQDN_FORTINET}    g-fortinet
${FIPSCC_TEST_W_FQDN_ITUNE}    g-itunes
${FIPSCC_TEST_W_FQDN_GROUP_1}    w.i*l&d-c=a+r_d@fqdn:group 1
#Schedule Variable
${FIPSCC_TEST_SCHEDULE_ALWAYS}    always
${FIPSCC_TEST_SCHEDULE_1}    robot: schedule.1
${FIPSCC_TEST_SCHEDULE_ONE_TIME_1}    one*time& s=c-h_e+d=u!l]e.1
${FIPSCC_TEST_SCHEDULE_GROUP_1}    robot%sch+dule,grp~1

#Service Variable
${FIPSCC_TEST_SERVICE_ALL}    ALL
${FIPSCC_TEST_SERVICE_1}    robot!service.1
${FIPSCC_TEST_SERVICE_2}    ip+service: 2
${FIPSCC_TEST_SERVICE_3}    w_source_port service-3
${FIPSCC_TEST_SERVICE_4}    icmp6~service% 4
${FIPSCC_TEST_SERVICE_5}    icmp&service$ * 5

${FIPSCC_TEST_SERVICE_GROUP_1}    srv:group.two service1    #FIPSCC_TEST_SERVICE_1 and FIPSCC_TEST_SERVICE_2
${FIPSCC_TEST_SERVICE_GROUP_2}    srv%!group,in=group 2    #FIPSCC_TEST_SERVICE_3, "Email Access", and FIPSCC_TEST_SERVICE_GROUP_1
${FIPSCC_TEST_SERVICE_GROUP_3}    srv[group]one*member 3    #FIPSCC_TEST_SERVICE_4

#User and User Group Variable
${FIPSCC_TEST_LDAP_SERVER}    ldap_server
${FIPSCC_TEST_LDAP_USER}    ldap_user

${FIPSCC_TEST_TACACS_P_SERVER}    tacacs+ server
${FIPSCC_TEST_TACACS_P_USER}    tac_user

${FIPSCC_TEST_RADIUS_SERVER}    radius server
${FIPSCC_TEST_RADIUS_USER}    radius_user

${FIPSCC_TEST_LOCAL_USER_1}    testuser1
${FIPSCC_TEST_LOCAL_USER_2}    Longnameuser withLastName2

${FIPSCC_TEST_USER_GROUP_1}    @US QA-Team 1   #FIPSCC_TEST_LOCAL_USER_1
${FIPSCC_TEST_USER_GROUP_2}    Team:CA[Salse] 2    #FIPSCC_TEST_LOCAL_USER_2 and three type of local user from remote server
${FIPSCC_TEST_USER_GROUP_3}    local user&from$remote_server 3    #three type of local user from remote server
${FIPSCC_TEST_USER_GROUP_4}    remote_Server.robot:test 4    #three type of remote server
${FIPSCC_TEST_LDAP_USER_GROUP}    ldap_user_group
${FIPSCC_TEST_RADIUS_USER_GROUP}    radius_user_group
${FIPSCC_TEST_TACACS_USER_GROUP}    tacacs_user_group

#Device and Device Group Variable
${FIPSCC_TEST_CUSTOM_DEVICE_1}    PC@QA_Team-1
${FIPSCC_TEST_CUSTOM_DEVICE_2}    MAC:BOOK=2

${FIPSCC_TEST_DEVICE_GROUP_1}    custom_device group    #FIPSCC_TEST_CUSTOM_DEVICE_1
${FIPSCC_TEST_DEVICE_GROUP_2}    custom_group+predefined Group    #FIPSCC_TEST_DEVICE_GROUP_1 and two predefined groups

${FIPSCC_TEST_DEVICE_GROUP_PREDEFINED_1}   android-device
${FIPSCC_TEST_DEVICE_GROUP_PREDEFINED_2}   collected-emails

#UTM profile group variable
${FIPSCC_TEST_UTM_PROFILE_GROUP_1}   &for@test:group 
${FIPSCC_TEST_UTM_PROFILE_GROUP_2}   +for test.group2 

#Traffic Shaper
${FIPSCC_TEST_SHAPER_SHARED_DEFAULT_1}    shared-1M-pipe
${FIPSCC_TEST_SHAPER_SHARED_DEFAULT_2}    high-priority
${FIPSCC_TEST_SHAPER_SHARED_DEFAULT_3}    low-priority
${FIPSCC_TEST_SHAPER_SHARED_DEFAULT_4}    medium-priority
${FIPSCC_TEST_SHAPER_SHARED_DEFAULT_5}    guarantee-100kbps
${FIPSCC_TEST_SHAPER_PER_IP_1}    *per&ip$shaper 1

#IP Pool
${FIPSCC_TEST_IP_POOLS_1}    Over-Load:type@ip*pool
${FIPSCC_TEST_IP_POOLS_2}    One to_One$tyep&ip+pool
${FIPSCC_TEST_IP_POOLS_3}    Fixed=Port[Range]ip%pool
${FIPSCC_TEST_IP_POOLS_4}    Port.Block/Allocation,ip;pool    
${FIPSCC_TEST_IP_POOLS6_1}    ipv6-robot[test] @ip&pool,1    
${FIPSCC_TEST_IP_POOLS6_2}    IPV6=robot.ip+pool_1

#vip
${FIPSCC_TEST_VIP_1}    vip~ipv4!
${FIPSCC_TEST_VIP6_1}    vip@ipv6/
${FIPSCC_TEST_VIP46_1}    vip$v4%v6
${FIPSCC_TEST_VIP64_1}    vip&v6*v4

${FIPSCC_TEST_VIP_GROUP_1}    vip-group_ipv4+
${FIPSCC_TEST_VIP6_GROUP_1}    vip[group]:ipv6;
${FIPSCC_TEST_VIP46_GROUP_1}    vip{group}v4,v6
${FIPSCC_TEST_VIP64_GROUP_1}    vip.group v6 v4
##End of Policy feature


##HTTP configuration
${FIPSCC_HTTP_IP}    172.16.200.55
${FIPSCC_HTTP_IP_V6}    2000:172:16:200::55
${FIPSCC_HTTP_PAGE_KEYWORD}    pc5

##HTTPS configuration
${FIPSCC_HTTPS_IP}    172.16.200.55
${FIPSCC_HTTPS_IP_V6}    2000:172:16:200::55
${FIPSCC_HTTPS_PAGE_KEYWORD}    pc5

##FTP configuration
${FIPSCC_FTP_HOST}    172.16.200.55
${FIPSCC_FTP_HOST_V6}    2000:172:16:200::55
${FIPSCC_FTP_USERNAME}    root
${FIPSCC_FTP_PASSWORD}    123456
${FIPSCC_FILE_UPLOAD_DIR_PATH}    ${CURDIR}${/}testdata
${FIPSCC_FILE_DOWNLOAD_DIR_PATH}    C:${/}Users${/}fosqa${/}Downloads
${FIPSCC_FTP_TEST_DIR}    FIPSCC_automation
${FIPSCC_FTP_TEST_FILE}    FIPSCC_automation.txt

##SFTP configuration
${FIPSCC_SFTP_HOST}    172.16.200.55
${FIPSCC_SFTP_HOST_V6}    2000:172:16:200::55
${FIPSCC_SFTP_USERNAME}    root
${FIPSCC_SFTP_PASSWORD}    123456
${FIPSCC_FILE_UPLOAD_DIR_PATH}    ${CURDIR}${/}testdata
${FIPSCC_FILE_DOWNLOAD_DIR_PATH}    C:${/}Users${/}fosqa${/}Downloads
${FIPSCC_SFTP_TEST_DIR}    FIPSCC_automation
${FIPSCC_SFTP_TEST_FILE}    FIPSCC_automation.txt

##SSH configuration
${FIPSCC_SSH_HOST}    172.16.200.55
${FIPSCC_SSH_HOST_V6}    2000:172:16:200::55
${FIPSCC_SSH_USERNAME}    root
${FIPSCC_SSH_PASSWORD}    123456

##TELNET configuration
${FIPSCC_TELNET_HOST}    172.16.200.55
${FIPSCC_TELNET_HOST_V6}    2000:172:16:200::55
${FIPSCC_TELNET_USERNAME}    root
${FIPSCC_TELNET_PASSWORD}    123456

##Ping configuration
${FIPSCC_PING_HOST}    172.16.200.55
${FIPSCC_PING_HOST_V6}    2000:172:16:200::55

##Settings on FGT used by FIPSCC
${FGT_USER_GROUP_NAME}    ssl-web-group
${FGT_ADDRESS_NAME}    office-network
${FGT_ADDRESS_SUBNET}    172.0.0.0 255.0.0.0
${FGT_FIPSCC_PORTAL_NAME}    testportal
${FGT_FIPSCC_REALM}    testrealm
${FGT_FIPSCC_ROUTING_ADDRESS_NAME}    FIPSCC_TUNNEL_ADDR1
${FGT_FIPSCC_ROUTING_IPV6_ADDRESS_NAME}    FIPSCC_TUNNEL_IPv6_ADDR1
${FGT_FIPSCC_INCOMING_INTERFACE_NAME}    ${FGT_VLAN20_INTERFACE}
${FGT_FIPSCC_SPLIT_DNS_DOMAIN}    test.qa.com
${FGT_FIPSCC_SPLIT_DNS_SERVER1}    8.8.8.8
${FGT_FIPSCC_SPLIT_DNS_SERVER2}    172.16.100.100
${FGT_FIPSCC_SPLIT_DNS_SERVER1_IPV6}    2001:4860:4860::8888
${FGT_FIPSCC_SPLIT_DNS_SERVER2_IPV6}    2000:172:16:100::100
${FGT_FIPSCC_ACCESS_HOST}    all
${FGT_FIPSCC_CLIENT_ADDRESS_RANGE}    FIPSCC_TUNNEL_ADDR1
${FGT_FIPSCC_CLIENT_IPV6_ADDRESS_RANGE}    FIPSCC_TUNNEL_IPv6_ADDR1
${FGT_FIPSCC_SERVER_CERTIFICATE}    ${FGT_HTTPS_CERTIFICATE_NAME}
${FGT_FIPSCC_OUTGOING_INTERFACE_NAME}    ${FGT_VLAN30_INTERFACE}
${FGT_POLICY_NAME_FOR_FIPSCC}    testpolicy
${FGT_POLICY_ID_FOR_FIPSCC}    1
${FGT_POLICY6_NAME_FOR_FIPSCC}    testpolicy6
${FGT_POLICY6_ID_FOR_FIPSCC}    1
${FGT_STATIC_ROUTER_ID_TO_OA}    1000
${FGT_STATIC_ROUTER_ID_TO_OA_IPV6}    1000

#Radius User config
${FGT_RADIUS_SERVER_NAME}    rad-srv
${FGT_RADIUS_SERVER_IP}    ${GENERAL_SERVER}
${FGT_RADIUS_SECRET}    123456
${FGT_RADIUS_GROUP_NAME}    rad-grp
${FGT_RADIUS_USERNAME}    test1
${FGT_RADIUS_PASSWORD}    123456

#LDAP User config
${FGT_LDAP_SERVER_NAME}    ldap-srv
${FGT_LDAP_SERVER_IP}    ${GENERAL_SERVER}
${FGT_LDAP_CNID}    uid
${FGT_LDAP_DN}    ou=users,dc=qa,dc=fortinet,dc=com
${FGT_LDAP_GROUP_NAME}    ldap-grp
${FGT_LDAP_USERNAME}    testuser1
${FGT_LDAP_PASSWORD}    testuser1

#Tacacs User config
${FGT_TACACS_SERVER_NAME}    tac-srv
${FGT_TACACS_SERVER_IP}    ${GENERAL_SERVER}
${FGT_TACACS_KEY}    123456
${FGT_TACACS_GROUP_NAME}    group_tac
${FGT_TACACS_USERNAME}    test_tac
${FGT_TACACS_PASSWORD}    123456

#Peer config
${FGT_PKI_PEER_NAME}    pkipeer
${FGT_PKI_PEER_CN}    *.fos.automation.com
${FGT_PKI_USER_GROUP}    pkigrp
${FGT_PKI_ADMIN_NAME}    pkiadmin

##Connectivity Settings
# FAZ from Vivian Wu
${FGT_FAZ_IP}    172.18.64.234
${FGT_FAZ_USERNAME}    fosqa
${FGT_FAZ_PASSWORD}    123456
# FMG from Jason Xue
${FGT_FMG_IP}    172.18.60.115
${FGT_FMG_USERNAME}    fosqa
${FGT_FMG_PASSWORD}    123456
${FGT_FMG_SN}    FMG-VM0A17009361
${FGT_FGD_ACCOUNT}    fosqa@fortinet.com
${FGT_FGD_PASSWORD}    123456
# FAC VM
${FAC_IP}    172.18.58.104
${FAC_USERNAME}    fosqa
${FAC_PASSWORD}    123456
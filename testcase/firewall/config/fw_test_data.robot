*** Settings ***
Documentation     This file contains data used for testing.

*** Variables ***
${FGT_HOSTNAME}    FW-GUI-Robot
${FW_CLI_FILE_DIR}    ${CURDIR}${/}cli
${REAL_SERVER_PC4_VLAN30}    172.16.200.44
${REAL_SERVER_PC5_VLAN30}    172.16.200.55

#Basic Setup Variable
${FW_TEST_VDOM_NAME_root}    root
${FW_TEST_VDOM_NAME_1}    test1
${FW_TEST_VDOM_NAME_2}    test2
${FW_TEST_VDOM_NAME_TP}    test_tp


#Address and Address Group Variable
#ipv4
${FW_TEST_ADDR_ALL}    all
${FW_TEST_ADDR_1}    robot!iprange$addr% 1    #created using iprange
${FW_TEST_ADDR_2}    robot_geo-addr= 2    #created using geo address
${FW_TEST_ADDR_3}    robot/fqdn,addr= 3    #created using fqdn
${FW_TEST_ADDR_4}    robot:sunet.addr= 4    #created using ipmask
${FW_TEST_ADDR_GROUP_1}    robot&addr@group 1    #FW_TEST_ADDR_1 and FW_TEST_ADDR_2
${FW_TEST_ADDR_GROUP_2}    robot.addr:group 2    #FW_TEST_ADDR_GROUP_1 and FW_TEST_ADDR_3
${FW_TEST_ADDR_GROUP_3}    robot!addr~group 3    #FW_TEST_ADDR_4
#ipv6
${FW_TEST_ADDR6_ALL}    all
${FW_TEST_ADDR6_TEMPLATE_1}    robot&addr6*template_1
${FW_TEST_ADDR6_TEMPLATE_2}    robot[addr6]template 2
${FW_TEST_ADDR6_1}    robot!subnet$addr6% 1    #creted using subnet
${FW_TEST_ADDR6_2}    robot_template2-addr6= 2    #created using template2
${FW_TEST_ADDR6_3}    robot/fqdn,addr6= 3    #created using fqdn
${FW_TEST_ADDR6_4}    robot:fqdn addr6= 4    #created using iprange
${FW_TEST_ADDR6_GROUP_1}    robot&addr6@group 1    #FW_TEST_ADDR6_1 and FW_TEST_ADDR6_2
${FW_TEST_ADDR6_GROUP_2}    robot.addr6:group 2    #FW_TEST_ADDR6_GROUP_1 and FW_TEST_ADDR6_3
${FW_TEST_ADDR6_GROUP_3}    robot_addr6 group 3    #FW_TEST_ADDR6_4
#multicast
${FW_TEST_MULTICAST_ADDR_ALL}    all

#Wildcard FQDN Address
${FW_TEST_ADDRESS_W_FQDN_DROPBOX}    wildcard.dropbox.com
${FW_TEST_ADDRESS_W_FQDN_GOOGLE}    wildcard.google.com
${FW_TEST_ADDRESS_W_FQDN_GROUP1}    addr*w& c=a-r_d+g=r!oup.1
${FW_TEST_ADDRESS_W_FQDN_GROUP2}    addr:w;c[a]r@d-group+2

${FW_TEST_W_FQDN_FORTINET}    g-fortinet
${FW_TEST_W_FQDN_ITUNE}    g-itunes
${FW_TEST_W_FQDN_GROUP_1}    w.i*l&d-c=a+r_d@fqdn:group 1


#Schedule Variable
${FW_TEST_SCHEDULE_ALWAYS}    always
${FW_TEST_SCHEDULE_1}    robot: schedule.1
${FW_TEST_SCHEDULE_ONE_TIME_1}    one*time& s=c-h_e+d=u!l]e.1
${FW_TEST_SCHEDULE_GROUP_1}    robot%sch+dule,grp~1

#Service Variable
${FW_TEST_SERVICE_ALL}    ALL
${FW_TEST_SERVICE_1}    robot!service.1
${FW_TEST_SERVICE_2}    ip+service: 2
${FW_TEST_SERVICE_3}    w_source_port service-3
${FW_TEST_SERVICE_4}    icmp6~service% 4
${FW_TEST_SERVICE_5}    icmp&service$ * 5

${FW_TEST_SERVICE_GROUP_1}    srv:group.two service1    #FW_TEST_SERVICE_1 and FW_TEST_SERVICE_2
${FW_TEST_SERVICE_GROUP_2}    srv%!group,in=group 2    #FW_TEST_SERVICE_3, "Email Access", and FW_TEST_SERVICE_GROUP_1
${FW_TEST_SERVICE_GROUP_3}    srv[group]one*member 3    #FW_TEST_SERVICE_4

#User and User Group Variable
${FW_TEST_LDAP_SERVER}    ldap_server
${FW_TEST_LDAP_USER}    ldap user1

${FW_TEST_TACACS_P_SERVER}    tacacs+ server
${FW_TEST_TACACS_P_USER}    tac_user test1

${FW_TEST_RADIUS_SERVER}    radius server
${FW_TEST_RADIUS_USER}    radius= user1

${FW_TEST_LOCAL_USER_1}    testuser1
${FW_TEST_LOCAL_USER_2}    Longnameuser withLastName2

${FW_TEST_USER_GROUP_1}    @US QA-Team 1   #FW_TEST_LOCAL_USER_1
${FW_TEST_USER_GROUP_2}    Team:CA[Salse] 2    #FW_TEST_LOCAL_USER_2 and three type of local user from remote server
${FW_TEST_USER_GROUP_3}    local user&from$remote_server 3    #three type of local user from remote server
${FW_TEST_USER_GROUP_4}    remote_Server.robot:test 4    #three type of remote server
${FW_TEST_LDAP_USER_GROUP}    ldap_user_group
${FW_TEST_RADIUS_USER_GROUP}    radius_user_group
${FW_TEST_TACACS_USER_GROUP}    tacacs_user_group

#Device and Device Group Variable
${FW_TEST_CUSTOM_DEVICE_1}    PC@QA_Team-1
${FW_TEST_CUSTOM_DEVICE_2}    MAC:BOOK=2

${FW_TEST_DEVICE_GROUP_PREDEFINED_1}   android-device
${FW_TEST_DEVICE_GROUP_PREDEFINED_2}   collected-emails

#UTM profile group variable
${FW_TEST_UTM_PROFILE_GROUP_1}   &for@test:group 
${FW_TEST_UTM_PROFILE_GROUP_2}   +for test.group2 

#Traffic Shaper
${FW_TEST_SHAPER_SHARED_DEFAULT_1}    shared-1M-pipe
${FW_TEST_SHAPER_SHARED_DEFAULT_2}    high-priority
${FW_TEST_SHAPER_SHARED_DEFAULT_3}    low-priority
${FW_TEST_SHAPER_SHARED_DEFAULT_4}    medium-priority
${FW_TEST_SHAPER_SHARED_DEFAULT_5}    guarantee-100kbps
${FW_TEST_SHAPER_PER_IP_1}    *per&ip$shaper 1

#IP Pool
${FW_TEST_IP_POOLS_1}    Over-Load:type@ip*pool
${FW_TEST_IP_POOLS_2}    One to_One$tyep&ip+pool
${FW_TEST_IP_POOLS_3}    Fixed=Port[Range]ip%pool
${FW_TEST_IP_POOLS_4}    Port.Block/Allocation,ip;pool    
${FW_TEST_IP_POOLS6_1}    ipv6-robot[test] @ip&pool,1    
${FW_TEST_IP_POOLS6_2}    IPV6=robot.ip+pool_1

#vip
${FW_TEST_VIP_1}    vip~ipv4!
${FW_TEST_VIP6_1}    vip@ipv6/
${FW_TEST_VIP46_1}    vip$v4%v6
${FW_TEST_VIP64_1}    vip&v6*v4

${FW_TEST_VIP_GROUP_1}    vip-group_ipv4+
${FW_TEST_VIP6_GROUP_1}    vip[group]:ipv6;
${FW_TEST_VIP46_GROUP_1}    vip{group}v4,v6
${FW_TEST_VIP64_GROUP_1}    vip.group v6 v4

#Policy46 ID
${FW_TEST_POLICY46_ID_1}    4001
#Policy64 ID
${FW_TEST_POLICY64_ID_1}    6001

#Multicast Policy ID
${FW_TEST_MULTICAST_POLICY_ID_1}    5001

#Policy ID
${FW_TEST_V4_POLICY_ID_1}    1001
${FW_TEST_V4_POLICY_ID_2}    1002
${FW_TEST_V4_POLICY_ID_3}    1003
${FW_TEST_V4_POLICY_ID_4}    10000004
${FW_TEST_V4_POLICY_ID_5}    1005
${FW_TEST_V4_POLICY_ID_6}    1006

${FW_TEST_V6_POLICY_ID_1}    2001
${FW_TEST_V6_POLICY_ID_2}    2002
${FW_TEST_V6_POLICY_ID_3}    2003
${FW_TEST_V6_POLICY_ID_4}    20000004
${FW_TEST_V6_POLICY_ID_5}    2005
${FW_TEST_V6_POLICY_ID_6}    2006

${FW_TEST_SHAPING_POLICY_ID_1}    3001
${FW_TEST_SHAPING_POLICY_ID_2}    3002

#UTM profile
${FW_TEST_UTM_G_DEFAULT}    g-default 
${FW_TEST_UTM_G_WIFI_DEFAULT}    g-wifi-default
${FW_TEST_SSL_SSH_PROFILE_CERT}    certificate-inspection
${FW_TEST_SSL_SSH_PROFILE_DEFAULT}    no-inspection

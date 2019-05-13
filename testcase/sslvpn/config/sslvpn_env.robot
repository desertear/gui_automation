*** Settings ***
Documentation     This file contains environment variables for SSLVPN

*** Variables ***
#variable GLOBAL_IF_CONFIG_FGT_FIRSTLY can be set as GUI, CLI, or False
${IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY}    GUI
#variable GLOBAL_IF_REMOVE_FGT_FINALLY can be set as GUI, CLI, or False
${IF_REMOVE_SSLVPN_ON_FGT_FINALLY}    CLI
#Timeout for SSLVPN cases running
${SSLVPN_MAX_RUNNING_TIME}    5 min

##Globale variables for SSLVPN GUI
${FGT_HOSTNAME}    ${FGT_SN}
${FGT_VLAN20_INTERFACE}    lan
${FGT_VLAN30_INTERFACE}    wan1

${SSLVPN_GUI_USERNAME}    user
${SSLVPN_GUI_PASSWORD}    123456
${SSLVPN_GUI_USERNAME2}    user2
${SSLVPN_GUI_PASSWORD2}    123456
${SSLVPN_HTTP_PROTOCOL}    https
${SSLVPN_IP_ADDRESS}   10.1.100.1
${SSLVPN_IP_ADDRESS_V6}   2000:10:1:100::1
${SSLVPN_PORT}    1443
${SSLVPN_URL}    ${SSLVPN_HTTP_PROTOCOL}://${SSLVPN_IP_ADDRESS}:${SSLVPN_PORT}
${SSLVPN_URL_V6}    ${SSLVPN_HTTP_PROTOCOL}://[${SSLVPN_IP_ADDRESS_V6}]:${SSLVPN_PORT}
#{SSLVPN_BROWSER} can be chrome, firefox and edge. browser names are case-insensitive and some browsers have multiple supported names
${SSLVPN_BROWSER}    chrome
#{SSLVPN_REMOTE_URL} is used for Selenium Grid
${SSLVPN_REMOTE_URL}    False
#FGT_RUNNING_PLATFORM should be one of {WINDOWS, XP, VISTA, MAC, LINUX, UNIX, ANDROID, ANY}
${SSLVPN_RUNNING_PLATFORM}    ANY
#refer to https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities for more DesiredCapabilities
${SSLVPN_DESIRED_CAPABILITIES}    ${EMPTY}
# ${SSLVPN_DESIRED_CAPABILITIES}    platform:${SSLVPN_RUNNING_PLATFORM},browserName:${SSLVPN_BROWSER}
${SSLVPN_FF_PROFILE_DIR}    None
${SSLVPN_CLI_FILE_DIR}    ${CURDIR}${/}cli
${SSLVPN_TIME_TOLERANCE}    10
${JS_WAITING_TIME}    2

##HTTP configuration
${SSLVPN_HTTP_IP}    172.16.200.55
${SSLVPN_HTTP_IP_V6}    2000:172:16:200::55
${SSLVPN_HTTP_PAGE_KEYWORD}    pc5

##HTTPS configuration
${SSLVPN_HTTPS_IP}    172.16.200.55
${SSLVPN_HTTPS_IP_V6}    2000:172:16:200::55
${SSLVPN_HTTPS_PAGE_KEYWORD}    pc5

#the name of certificate that HTTPS uses.

${FGT_HTTPS_CERTIFICATE_NAME}    fgt_gui_automation
${FGT_PKI_PEER_CA_NAME}    pkica

${GENERAL_SERVER}    172.16.200.55

##FGT common configuration
${FGT_VLAN10_IP}    10.6.30.1
${FGT_VLAN10_IP_V6}    2000:10:6:30::1
${FGT_VLAN30_IP}    172.16.200.1
${FGT_VLAN30_IP_V6}    2000:172:16:200::1
#Because GUI access IPs can be mapped to external IPs.Below Vlan20 addresses are used internal.
${FGT_VLAN20_IP}    10.1.100.1
${FGT_VLAN20_IP_V6}    2000:10:1:100::1
${FGT_VLAN30_GATEWAY}    172.16.200.254
${FGT_VLAN30_GATEWAY_V6}    2000:172:16:200::254
${FGT_DNS_SERVER1}    8.8.8.8
${FGT_DNS_SERVER2}    172.16.100.100
${FGT_DNS_SERVER1_IPV6}    2001:4860:4860::8888
${FGT_DNS_SERVER2_IPV6}    2000:172:16:100::100

#Settings of FGT mode. If you don't need to switch FGT mode, don't update them.
${FGT_LENC_MODE}    False
${FGT_FACTORY_LICENSE}    1234567890
${FGT_LENC_LICENSE}    1234567890
${FGT_LOW_CRYPTO_LICENSE}    1234567890

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

##PC5 configurations
${PC5_VLAN10_IP}    10.6.30.55
${PC5_VLAN30_IP}    172.16.200.55
${PC5_SSH_PORT}    22
${PC5_USERNAME}    root
${PC5_PASSWORD}    123456
${PC5_OS_TYPE}    Linux
${PC5_SSH_PROMPT}    ~[\#\$]
${PC5_SSH_TIMEOUT}    20 seconds

##PC4 configurations
${PC4_VLAN10_IP}    10.6.30.44
${PC4_VLAN30_IP}    172.16.200.44
${PC4_SSH_PORT}    22
${PC4_USERNAME}    root
${PC4_PASSWORD}    123456
${PC4_OS_TYPE}    Linux
${PC4_SSH_PROMPT}    ~[\#\$]
${PC4_SSH_TIMEOUT}    20 seconds

##FTP configuration
${SSLVPN_FTP_HOST}    172.16.200.55
${SSLVPN_FTP_HOST_V6}    2000:172:16:200::55
${SSLVPN_FTP_USERNAME}    root
${SSLVPN_FTP_PASSWORD}    123456
${SSLVPN_FILE_UPLOAD_DIR_PATH}    ${CURDIR}${/}testdata
${SSLVPN_FILE_DOWNLOAD_DIR_PATH}    C:${/}Users${/}fosqa${/}Downloads
${SSLVPN_FTP_TEST_DIR}    sslvpn_automation
${SSLVPN_FTP_TEST_FILE}    sslvpn_automation.txt

##SFTP configuration
${SSLVPN_SFTP_HOST}    172.16.200.55
${SSLVPN_SFTP_HOST_V6}    2000:172:16:200::55
${SSLVPN_SFTP_USERNAME}    root
${SSLVPN_SFTP_PASSWORD}    123456
${SSLVPN_FILE_UPLOAD_DIR_PATH}    ${CURDIR}${/}testdata
${SSLVPN_FILE_DOWNLOAD_DIR_PATH}    C:${/}Users${/}fosqa${/}Downloads
${SSLVPN_SFTP_TEST_DIR}    sslvpn_automation
${SSLVPN_SFTP_TEST_FILE}    sslvpn_automation.txt

##SMBv2 configuration
${SSLVPN_SMB_HOST}    172.16.200.55
${SSLVPN_SMB_HOST_V6}    2000:172:16:200::55
${SSLVPN_SMB_USERNAME}    root
${SSLVPN_SMB_PASSWORD}    123456
${SSLVPN_SMB_MOST_UPPER_DIR}    root
${SSLVPN_SMB_TEST_DIR}    sslvpn_automation
${SSLVPN_SMB_TEST_FILE}    sslvpn_automation.txt

##SMBv1 configuration
${SSLVPN_SMBv1_HOST}    172.16.200.33
${SSLVPN_SMBv1_HOST_V6}    2000:172:16:200::33
${SSLVPN_SMBv1_USERNAME}    fosqa
${SSLVPN_SMBv1_PASSWORD}    123456
${SSLVPN_SMBv1_MOST_UPPER_DIR}    smb_share
${SSLVPN_SMBv1_TEST_DIR}    sslvpn_automation
${SSLVPN_SMBv1_TEST_FILE}    sslvpn_automation.txt

##RDP configuration
${SSLVPN_RDP_HOST}    172.16.200.33
${SSLVPN_RDP_HOST_V6}    2000:172:16:200::33
${SSLVPN_RDP_PORT}    3389
${SSLVPN_RDP_USERNAME}    fosqa
${SSLVPN_RDP_PASSWORD}    123456

##VNC configuration
${SSLVPN_VNC_HOST}    172.16.200.55
${SSLVPN_VNC_HOST_V6}    2000:172:16:200::55
${SSLVPN_VNC_PORT}    5901
${SSLVPN_VNC_PASSWORD}    123456

##SSH configuration
${SSLVPN_SSH_HOST}    172.16.200.55
${SSLVPN_SSH_HOST_V6}    2000:172:16:200::55
${SSLVPN_SSH_USERNAME}    root
${SSLVPN_SSH_PASSWORD}    123456

##TELNET configuration
${SSLVPN_TELNET_HOST}    172.16.200.55
${SSLVPN_TELNET_HOST_V6}    2000:172:16:200::55
${SSLVPN_TELNET_USERNAME}    root
${SSLVPN_TELNET_PASSWORD}    123456

##Ping configuration
${SSLVPN_PING_HOST}    172.16.200.55
${SSLVPN_PING_HOST_V6}    2000:172:16:200::55

##Settings on FGT used by SSLVPN
${FGT_USER_GROUP_NAME}    ssl-web-group
${FGT_ADDRESS_NAME}    office-network
${FGT_ADDRESS_SUBNET}    172.0.0.0 255.0.0.0
${FGT_SSLVPN_PORTAL_NAME}    testportal
${FGT_SSLVPN_REALM}    testrealm
${FGT_SSLVPN_ROUTING_ADDRESS_NAME}    SSLVPN_TUNNEL_ADDR1
${FGT_SSLVPN_ROUTING_IPV6_ADDRESS_NAME}    SSLVPN_TUNNEL_IPv6_ADDR1
${FGT_SSLVPN_INCOMING_INTERFACE_NAME}    ${FGT_VLAN20_INTERFACE}
${FGT_SSLVPN_SPLIT_DNS_DOMAIN}    test.qa.com
${FGT_SSLVPN_SPLIT_DNS_SERVER1}    8.8.8.8
${FGT_SSLVPN_SPLIT_DNS_SERVER2}    172.16.100.100
${FGT_SSLVPN_SPLIT_DNS_SERVER1_IPV6}    2001:4860:4860::8888
${FGT_SSLVPN_SPLIT_DNS_SERVER2_IPV6}    2000:172:16:100::100
${FGT_SSLVPN_ACCESS_HOST}    all
${FGT_SSLVPN_CLIENT_ADDRESS_RANGE}    SSLVPN_TUNNEL_ADDR1
${FGT_SSLVPN_CLIENT_IPV6_ADDRESS_RANGE}    SSLVPN_TUNNEL_IPv6_ADDR1
${FGT_SSLVPN_SERVER_CERTIFICATE}    ${FGT_HTTPS_CERTIFICATE_NAME}
${FGT_SSLVPN_OUTGOING_INTERFACE_NAME}    ${FGT_VLAN30_INTERFACE}
${FGT_POLICY_NAME_FOR_SSLVPN}    testpolicy
${FGT_POLICY_ID_FOR_SSLVPN}    1
${FGT_POLICY6_NAME_FOR_SSLVPN}    testpolicy6
${FGT_POLICY6_ID_FOR_SSLVPN}    1
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

# 6.2    172.18.58.101
# 6.0.3    172.18.58.102
# 5.6.6    172.18.58.103
${FGT_6.2}    https://172.18.58.101
${FGT_6.0}    https://172.18.58.102
${FGT_5.6}    https://172.18.58.103

${url_wiki_216753}    https://wiki.fortinet.com/twiki/bin/view/Main/WebHome
${url_oriole_589691}    http://172.16.100.117/qatask
${url_fortinet}    https://www.fortinet.com/
${url_fortcare_721590}    https://forticare.fortinet.com
${url_iportal_862519}    https://oa.apo.myfortinet.com
##SSO Login Test
${sso_http}    http://172.18.58.104/login
${sso_https}    https://172.18.58.104/login
${sso_username}    fosqa
${sso_password}    123456

${SSLVPN_LINUX_SERVER2}    172.18.58.114
${SSLVPN_WIN_SERVER2}    172.18.58.209

${WIN_DEFINDER_AV}    D68DDC3A-831F-4fae-9E44-DA132C1ACF46
${FORTICLIENT_AV}    1A0271D5-3D4F-46DB-0C2C-AB37BA90D9F7

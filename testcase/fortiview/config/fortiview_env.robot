*** Settings ***
Documentation     This file contains environment variables for FORTIVIEW

*** Variables ***
#variable GLOBAL_IF_CONFIG_FGT_FIRSTLY can be set as GUI, CLI, or False
${IF_CONFIG_FORTIVIEW_ON_FGT_FIRSTLY}    CLI
#variable GLOBAL_IF_REMOVE_FGT_FINALLY can be set as GUI, CLI, or False
${IF_REMOVE_FORTIVIEW_ON_FGT_FINALLY}    CLI

${VLAN10PORT}    wan1
${VLAN20PORT}    port2
${VLAN30PORT}    port3

${VLAN10PORT_IP}    10.6.30.7 255.255.255.0
${VLAN20PORT_IP}    10.1.100.7 255.255.255.0
${VLAN30PORT_IP}    172.16.200.7 255.255.255.0

${VLAN10PORT_IPV6IP}    2000:10:6:30::7/64
${VLAN20PORT_IPV6IP}    2000:10:1:100::7/64
${VLAN30PORT_IPV6IP}    2000:172:16:200::7/64


#{FORTIVIEW_BROWSER} can be chrome, firefox and edge. browser names are case-insensitive and some browsers have multiple supported names
${FORTIVIEW_BROWSER}    chrome

#PC1 setup
#variable IF_CONFIG_PC1 can be set as true or false, true means to configure pc1
${IF_CONFIG_PC1}    true







#Timeout for SSLVPN cases running
${SSLVPN_MAX_RUNNING_TIME}    5 min
##Globale variables for SSLVPN GUI
${FORTIVIEW_GUI_USERNAME}    admin
${FORTIVIEW_GUI_PASSWORD}    ${EMPTY}
${SSLVPN_HTTP_PROTOCOL}    https
${SSLVPN_IP_ADDRESS}   10.1.100.1
${SSLVPN_IP_ADDRESS_V6}   2000:10:1:100::1
${SSLVPN_PORT}    1443
${SSLVPN_URL}    ${SSLVPN_HTTP_PROTOCOL}://${SSLVPN_IP_ADDRESS}:${SSLVPN_PORT}
${SSLVPN_URL_V6}    ${SSLVPN_HTTP_PROTOCOL}://[${SSLVPN_IP_ADDRESS_V6}]:${SSLVPN_PORT}

#{SSLVPN_REMOTE_URL} is used for Selenium Grid
${SSLVPN_REMOTE_URL}    False
#FGT_RUNNING_PLATFORM should be one of {WINDOWS, XP, VISTA, MAC, LINUX, UNIX, ANDROID, ANY}
${SSLVPN_RUNNING_PLATFORM}    ANY
#refer to https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities for more DesiredCapabilities
${SSLVPN_DESIRED_CAPABILITIES}    ${EMPTY}
# ${SSLVPN_DESIRED_CAPABILITIES}    platform:${SSLVPN_RUNNING_PLATFORM},browserName:${SSLVPN_BROWSER}
${SSLVPN_FF_PROFILE_DIR}    None
${FORTIVIEW_CLI_FILE_DIR}    ${CURDIR}${/}cli
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

##FTP configuration
${SSLVPN_FTP_HOST}    172.16.200.55
${SSLVPN_FTP_HOST_V6}    2000:172:16:200::55
${SSLVPN_FTP_USERNAME}    root
${SSLVPN_FTP_PASSWORD}    123456
${SSLVPN_FILE_UPLOAD_DIR_PATH}    ${CURDIR}${/}testdata
${SSLVPN_FILE_DOWNLOAD_DIR_PATH}    C:${/}Users${/}fosqa${/}Downloads
${SSLVPN_FTP_TEST_DIR}    sslvpn_automation
${SSLVPN_FTP_TEST_FILE}    sslvpn_automation.txt

##SMB configuration
${SSLVPN_SMB_HOST}    172.16.200.55
${SSLVPN_SMB_HOST_V6}    2000:172:16:200::55
${SSLVPN_SMB_USERNAME}    root
${SSLVPN_SMB_PASSWORD}    123456
${SSLVPN_SMB_MOST_UPPER_DIR}    root
${SSLVPN_SMB_TEST_DIR}    sslvpn_automation
${SSLVPN_SMB_TEST_FILE}    sslvpn_automation.txt

##RDP configuration
${SSLVPN_RDP_HOST}    172.18.58.116
${SSLVPN_RDP_HOST_V6}    2000:172:18:58::116
${SSLVPN_RDP_PORT}    3389
${SSLVPN_RDP_USERNAME}    fosqa
${SSLVPN_RDP_PASSWORD}    123456

##VNC configuration
${SSLVPN_VNC_HOST}    172.16.200.55
${SSLVPN_VNC_HOST_V6}    2000:172:16:200::55
${SSLVPN_VNC_PORT}    5901
${SSLVPN_VNC_CONNECTION_PASSWORD}    123456
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

${url_previous_fgt_853611}    https://172.16.106.50
${url_same_fgt_183056}    https://172.16.200.1
${url_newer_fgt_853610}    https://172.16.106.50
${url_wiki_216753}    https://wiki.fortinet.com/twiki/bin/view/Main/WebHome
${url_oriole_589691}    http://172.16.100.117/qatask
${url_fortinet_796047}    https://www.fortinet.com/
${url_fortcare_721590}    https://forticare.fortinet.com
${url_iportal_862519}    https://oa.apo.myfortinet.com
##FGT for Login Test
${url_test_fgt_http}    http://172.18.58.81/login
${url_test_fgt_https}    https://172.16.200.1/login
${url_fac}    http://172.18.58.107/login/
${fgt_sso_username}    fosqa
${fgt_sso_password}    123456
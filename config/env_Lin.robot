*** Settings ***
Documentation     This file contains common environment variables
Resource    ./env.robot

*** Variables ***
#below value should be set manually.
${FGT_SN}    FGT6HD3915800042
#${FGT_HOSTNAME}    ${FGT_SN}
${FGT_HOSTNAME}    FortiGate-600D
${FGT_GENERATION}    Gen1
${FGT_TEST_VERSION}    6.2.0
${BRANCH_NAME}    ${EMPTY}
${FGT_GUI_ACCESS_INTERFACE}    port13
${FGT_VLAN10_INTERFACE}    mgmt
${FGT_VLAN20_INTERFACE}    port13
${FGT_VLAN30_INTERFACE}    port14
${GENERAL_SERVER}    172.16.200.55
${FGT_CLI_LOG_DIR}    ${CURDIR}${/}..${/}log
${FW_TEST_VDOM_NAME_1}    vd1
#your LDAP account to login Oriole, you need to change it once you change your ldap password
${ORIOLE_ACCOUNT}    ljia
#this one can be get from "user profile" after you login Oriole
${ORIOLE_ENCODED_PASSWORD}      VlRGc1ZsaFdXbU5FVVhSS1ZWRldWbFZvTVZGQ1VVRktVMUZaUkVSblNrcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw==

#Jenkins' ID and URL, you don't need to alter them.
${JENKINS_ID}    ${EMPTY}
${JENKINS_URL}    ${EMPTY}

##cases execution parameters
${GLOBAL_REPORT_TO_ORIOLE}    True
#Timeout for case running
${FGT_MAX_RUNNING_TIME}    5 min
#Timeout for all keywords
${FGT_KEYWORD_MAX_RUNNING_TIME}    2 min

#don't change below two variables unless you know them.
${ORIOLE_SUBMIT_URL}    http://172.16.100.117/wsqadb/AutoTestResult?wsdl
${ORIOLE_TASK_PATH}    /FOS/RLS_V/Regression/
#set the report directory where you want to store all reports(.txt and .json)
${REPORT_FILE_TXT_PATH}    ${CURDIR}${/}..${/}result
${REPORT_FILE_JSON_PATH}    ${REPORT_FILE_TXT_PATH}
#Sikuli image directory
${SIKULI_IMAGE_DIR}     ${CURDIR}${/}image
#ImageMagick Dir
${IMAGEMAGICK_DIR}    C:${/}"Program Files"${/}ImageMagick-7.0.8-Q16${/}magick.exe

#Selenium global configuration
${SCREEN_SIZE_WIDTH}    1600
${SCREEN_SIZE_HEIGTH}    900
${SELENIUM_IMPLICIT_WAIT}    0
${SELENIUM_TIMEOUT}    5
${SELENIUM_SPEED}    0.1
${SELENIUM_SCREENSHOT_DIR}    ${CURDIR}${/}..${/}..${/}screenshot


##variables for FortiGate GUI
${FGT_GUI_USERNAME}    admin
${FGT_GUI_PASSWORD}    ${EMPTY}
${FGT_HTTP_PROTOCOL}    https
${FGT_IP_ADDRESS}   10.1.100.1
${FGT_IP_ADDRESS_V6}   2000:10:1:100::1
${FGT_PORT}    443
${FGT_URL}    ${FGT_HTTP_PROTOCOL}://${FGT_IP_ADDRESS}:${FGT_PORT}
${FGT_URL_IPV6}    ${FGT_HTTP_PROTOCOL}://[${FGT_IP_ADDRESS_V6}]:${FGT_PORT}
#$FGT_BROWSER} can be chrome, firefox and edge. browser names are case-insensitive and some browsers have multiple supported names
${FGT_BROWSER}    chrome
#{FGT_REMOTE_URL} is used for Selenium Grid
${FGT_REMOTE_URL}    False
#FGT_RUNNING_PLATFORM should be one of {WINDOWS, XP, VISTA, WIN8_1, WIN10, MAC, LINUX, UNIX, ANDROID, ANY}
${FGT_RUNNING_PLATFORM}    ANY
#format of ${FGT_DESIRED_CAPABILITIES} can be platform:${FGT_RUNNING_PLATFORM},browserName:${FGT_BROWSER}
${FGT_DESIRED_CAPABILITIES}    ${EMPTY}
${FGT_FF_PROFILE_DIR}    None
#the name of certificate that HTTPS uses.
${FGT_HTTPS_CERTIFICATE_NAME}    fgt_gui_automation

##CLI Configuration
${FGT_CLI_USERNAME}    admin
${FGT_CLI_PASSWORD}    ${EMPTY}
${FGT_CLI_PROMPT}    ${FGT_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGT_CLI_NEWLINE}    \r\n   
${FGT_CLI_FILE_DIR}    ${CURDIR}${/}cli
${TFTP_IMAGE_SERVER_IP}    ${GENERAL_SERVER}
#FGT Terminal Server configuration
${TERMINAL_SERVER_IP}    172.18.62.48
${TERMINAL_SERVER_PORT}    23
${FGT_TELNET_PORT_ON_TERMINAL_SERVER}    2005
${TERMINAL_SERVER_USER_PASSWORD}    ${EMPTY}
${TERMINAL_SERVER_ADMIN_PASSWORD}    ${EMPTY}
${TERMINAL_SERVER_PROMPT}    .*\#|\>|Password:
${TERMINAL_SERVER_NEWLINE}    \r\n

##FGT info that is checked on GUI, You don't need to update them, becauase they can be set automatically.
${FGT_HW_TYPE}    FortiWiFi60E

##FGT info, that is used to form JSON file.You don't need to update them, becauase they can be set automatically.
${FGT_AV_DEF}    1.00123
${FGT_AV_ENG}    6.00006
${FGT_BIOS}    05000004
${FGT_BUILD}    0112
${FGT_IPS_DEF}    6.00741
${FGT_IPS_ENG}    4.00016
${FGT_TYPE}    FWF_60E
${FGT_VDOM_STATUS}    False


#FGT mode
${FGT_FIPS_CC_MODE}    False
${FGT_LENC_MODE}    False
${FGT_FACTORY_LICENSE}    1234567890
${FGT_LENC_LICENSE}    1234567890
${FGT_LOW_CRYPTO_LICENSE}    1234567890

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
${FGT_STATIC_ROUTER_ID_TO_OA}    1000
${FGT_STATIC_ROUTER_ID_TO_OA_IPV6}    1000
${FGT_DNS_SERVER1}    172.16.95.16
${FGT_DNS_SERVER2}    172.16.100.100
${FGT_DNS_SERVER1_IPV6}    2001:4860:4860::8888
${FGT_DNS_SERVER2_IPV6}    2000:172:16:100::100
${FGT_POLICY4_NAME}    main

##Connectivity Settings
${FGT_FAZ_IP}    172.16.106.42
${FGT_FAZ_USERNAME}    admin
${FGT_FAZ_PASSWORD}    ${EMPTY}
${FGT_FMG_IP}    172.16.106.32
${FGT_FMG_USERNAME}    admin
${FGT_FMG_PASSWORD}    ${EMPTY}
${FGT_FMG_SN}    FMG-VM0A12000213
${FGT_FGD_ACCOUNT}    fosqa@fortinet.com
${FGT_FGD_PASSWORD}    123456

##PC5 configurations
${PC5_VLAN10_IP}    10.6.30.55
${PC5_VLAN30_IP}    172.16.200.55
${PC5_SSH_PORT}    22
${PC5_USERNAME}    root
${PC5_PASSWORD}    123456
${PC5_OS_TYPE}    Linux
${PC5_SSH_PROMPT}    \#
${PC5_SSH_TIMEOUT}    5 seconds

##PC1 configurations
${PC1_VLAN10_IP}    10.6.30.11
${PC1_VLAN20_IP}    10.1.100.11
${PC5_SSH_PORT}    22
${PC1_USERNAME}    root
${PC1_PASSWORD}    123456
${PC1_OS_TYPE}    Linux
${PC1_SSH_PROMPT}    \#
${PC1_SSH_TIMEOUT}    5 seconds

##PC4 configurations
${PC4_VLAN10_IP}    10.6.30.216
${PC4_VLAN30_IP}    172.16.200.216
${PC5_SSH_PORT}    22
${PC4_USERNAME}    root
${PC4_PASSWORD}    123456
${PC4_OS_TYPE}    Linux
${PC4_SSH_PROMPT}    \#
${PC4_SSH_TIMEOUT}    5 seconds

##PC2 configurations
${PC2_VLAN10_IP}    10.6.30.22
${PC2_VLAN20_IP}    10.1.100.22
${PC5_SSH_PORT}    22
${PC2_USERNAME}    root
${PC2_PASSWORD}    123456
${PC2_OS_TYPE}    Linux
${PC2_SSH_PROMPT}    \#
${PC2_SSH_TIMEOUT}    5 seconds

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
${FGT_PKI_PEER_CA_NAME}    pkica
${FGT_PKI_PEER_CN}    *.fos.automation.com
${FGT_PKI_USER_GROUP}    pkigrp
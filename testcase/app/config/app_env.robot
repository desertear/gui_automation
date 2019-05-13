*** Settings ***
Documentation     This file contains environment variables for APP

*** Variables ***

${APP_CLI_FILE_DIR}    ${CURDIR}${/}cli

${REAL_SERVER_PC4_VLAN30}    172.16.200.216
${REAL_SERVER_PC5_VLAN30}    172.16.200.55

#Basic Setup Variable
${APP_TEST_VDOM_NAME_root}    root
${APP_TEST_VDOM_NAME_1}    vd1

#Interface Variable
${APP_TEST_INTF_1}    port14
${APP_TEST_INTF_2}    port13
${APP_TEST_INTF_13}    port9
${APP_TEST_INTF_ANY}    any

#Address and Address Group Variable

#ipv4
${APP_TEST_INTF_1_IP}    172.16.200.1
${APP_TEST_INTF_2_IP}    10.1.100.1

#ipv6
${APP_TEST_INTF_1_IP6}    2001:172:16:200::1
${APP_TEST_INTF_2_IP6}    2001:10:1:100::1

#multicast
${APP_TEST_MULTICAST_ADDR_ALL}    all

#UTM profile
${APP_TEST_UTM_G_DEFAULT}    g-default 
${APP_TEST_SSL_SSH_PROFILE_CERT}    certificate-inspection
${APP_TEST_SSL_SSH_PROFILE_DEEP}    new-deep-inspection

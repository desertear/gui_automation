*** Settings ***
Documentation     This file contains environment variables for webfilter

*** Variables ***

${WEBFILTER_CLI_FILE_DIR}    ${CURDIR}${/}cli

#Basic Setup Variable
${WEBFILTER_TEST_VDOM_NAME_root}    root
${WEBFILTER_TEST_VDOM_NAME_1}    vdom1

#Interface Variable
${WEBFILTER_TEST_CLIENT_INTF}    wan2
${WEBFILTER_TEST_CLIENT_INTF_IP}    10.1.200.6
${WEBFILTER_TEST_SERVER_INTF}    wan1
${WEBFILTER_TEST_SERVER_INTF_IP}    172.16.20.6

#Address and Address Group Variable

#ipv4
${WEBFILTER_TEST_CLIENT_PC_IP}      10.1.200.15
${WEBFILTER_TEST_SERVER_PC_IP}      172.16.200.60


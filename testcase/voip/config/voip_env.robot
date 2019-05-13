*** Settings ***
Documentation     This file contains environment variables for VOIP

*** Variables ***

${VOIP_CLI_FILE_DIR}    ${CURDIR}${/}cli

#Basic Setup Variable
${VOIP_TEST_VDOM_NAME_root}    root
${VOIP_TEST_VDOM_NAME_1}    vdom1

#Interface Variable
${VOIP_TEST_CLIENT_INTF}    port1
${VOIP_TEST_CLIENT_INTF_IP}    10.1.100.2
${VOIP_TEST_SERVER_INTF}    port2
${VOIP_TEST_SERVER_INTF_IP}    110.110.110.2

#Address and Address Group Variable

#ipv4
${VOIP_TEST_CLIENT_PC_IP}    10.1.100.155
${VOIP_TEST_SERVER_PC_IP}    172.16.200.144
${VOIP_IPV4_POLICY_NAME}    VOIP-Policy


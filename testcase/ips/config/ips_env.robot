*** Settings ***
Documentation     This file contains environment variables for IPS

*** Variables ***

${IPS_CLI_FILE_DIR}    ${CURDIR}${/}cli

#Basic Setup Variable
${IPS_TEST_VDOM_NAME_root}    root
${IPS_TEST_VDOM_NAME_1}    vdom1

#Interface Variable
${IPS_TEST_CLIENT_INTF}    port2
${IPS_TEST_CLIENT_INTF_IP}    10.1.100.5
${IPS_TEST_SERVER_INTF}    port1
${IPS_TEST_SERVER_INTF_IP}    172.16.200.5

#Address and Address Group Variable

#ipv4
${IPS_TEST_CLIENT_PC_IP}    10.1.100.12
${IPS_TEST_SERVER_PC_IP}    172.16.200.56
${IPS_IPV4_POLICY_NAME}    test


*** Settings ***
Documentation     This file contains environment variables for DLP

*** Variables ***

${DLP_CLI_FILE_DIR}    ${CURDIR}${/}cli

#Basic Setup Variable
${DLP_TEST_VDOM_NAME_root}    root
${DLP_TEST_VDOM_NAME_1}    vdom1

#Interface Variable
${DLP_TEST_CLIENT_INTF}    port2
${DLP_TEST_CLIENT_INTF_IP}    10.1.100.5
${DLP_TEST_SERVER_INTF}    port1
${DLP_TEST_SERVER_INTF_IP}    172.16.200.5

#Address and Address Group Variable

#ipv4
${DLP_TEST_CLIENT_PC_IP}    10.1.100.12
${DLP_TEST_SERVER_PC_IP}    172.16.200.56
${DLP_IPV4_POLICY_NAME}    test


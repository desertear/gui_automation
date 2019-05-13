*** Settings ***
Documentation     This file contains environment variables for WANOPT

*** Variables ***

${WANOPT_CLI_FILE_DIR}    ${CURDIR}${/}cli

#Basic Setup Variable
${WANOPT_TEST_VDOM_NAME_root}    root
${WANOPT_TEST_VDOM_NAME_1}    vdom1

#Interface Variable
${WANOPT_TEST_CLIENT_INTF}    port1
${WANOPT_TEST_CLIENT_INTF_IP}    10.1.100.2
${WANOPT_TEST_SERVER_INTF}    port2
${WANOPT_TEST_SERVER_INTF_IP}    110.110.110.2

#Address and Address Group Variable

#ipv4
${WANOPT_TEST_CLIENT_PC_IP}    10.1.100.155
${WANOPT_TEST_SERVER_PC_IP}    172.16.200.144
${WANOPT_IPV4_POLICY_NAME}    WANOPT-Policy


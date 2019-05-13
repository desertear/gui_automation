*** Settings ***
Documentation    Verify vip object with dns-translation and fqdn types can display properly on VIP editing page
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${test_vip_dns}     832184_41
${test_vip_fqdn}    832184_42
${test_vip_dns_exip_start}     172.16.202.100
${test_vip_dns_exip_end}       172.16.202.120
${test_vip_dns_mapedip_start}    10.1.102.100
${test_vip_dns_mapedip_end}      10.1.102.200
${test_vip_dns_filter_srcip}   10.1.102.120-10.2.102.121
${test_vip_dns_ex_port_start}     100
${test_vip_dns_ex_port_end}       110
${test_vip_dns_mapped_port_start}    2100
${test_vip_dns_mapped_port_end}      2110
${test_vip_fqdn_exip}      172.16.202.200
${test_vip_fqdn_mapaddr}   ${FW_TEST_ADDR_3}
*** Test Cases ***
832184
    [Documentation]
    [Tags]    chrome    832184    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: dns-translation is shown on address page
    Log    ==================== Step 1: verify dns-translation shown correct on address page ====================
    Go to Virtual IP
    Open Section Label on VIP List    IPv4 Virtual IP   
    Edit VIP By Name on VIP List    IPv4 Virtual IP   ${test_vip_dns}
    check vip type info shown on VIP page   DNS Translation
    check ipmap info shown on VIP page    4    External IP Address/Range    1    ${test_vip_dns_exip_start}
    check ipmap info shown on VIP page    4    External IP Address/Range    2    ${test_vip_dns_exip_end}
    check ipmap info shown on VIP page    4    Mapped IP Address/Range    1    ${test_vip_dns_mapedip_start}
    check ipmap info shown on VIP page    4    Mapped IP Address/Range    2    ${test_vip_dns_mapedip_end}
    check portmap info shown on VIP page  External Service Port      1    ${test_vip_dns_ex_port_start}
    check portmap info shown on VIP page  External Service Port      2    ${test_vip_dns_ex_port_end}
    check portmap info shown on VIP page  Map to Port      1    ${test_vip_dns_mapped_port_start}
    check portmap info shown on VIP page  Map to Port      2    ${test_vip_dns_mapped_port_end}
    check filter src addr info shown on VIP page    1    ${test_vip_dns_filter_srcip}
    Click Cancel Button on Virtual IP Editor
# Step 1: fqdn is shown on address page
    Log    ==================== Step 2: verify fqdn shown correct on address page ====================
    Edit VIP By Name on VIP List    IPv4 Virtual IP   ${test_vip_fqdn}
    check vip type info shown on VIP page   FQDN
    check fqdn exip info shown on VIP page    ${test_vip_fqdn_exip}
    check fqdn mapped addr info shown on VIP page    ${test_vip_fqdn_mapaddr}
    Click Cancel Button on Virtual IP Editor
    Unselect Frame    
    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

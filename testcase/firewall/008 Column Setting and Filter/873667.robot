*** Settings ***
Documentation    Verify policy filter for interface-pair/sequence-grouping label can be shown and work as expected when collapse all policy entries (M504474)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${sslvpn_intf}    SSL-VPN tunnel interface (ssl.${FW_TEST_VDOM_NAME_1})

*** Test Cases ***
873667
    [Documentation]    
    [Tags]    chrome    873667    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

    #Step 1: Test ipv4 policy
    Log    ==================== Step 1: Test ipv4 policy ====================
    Go to IPv4 policy
    View By Interface Pair View
    ####Set Filter Text For Interface Pair####
    ${filter}=    Create Dictionary    operator=Contains    from=${FW_TEST_INTF_2}    to=${FW_TEST_INTF_1}    set_method=list
    Set Policy Interface Pair Filter    4    &{filter}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    2
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_2}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    any    NO
    Remove Policy Interface Pair Filters
    ####Set Filter Text For Interface Pair####
    ${filter}=    Create Dictionary    operator=Does Not Contain    from=ipsec    to=${FW_TEST_INTF_2}    set_method=text
    Set Policy Interface Pair Filter    4    &{filter}
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    2
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_2}    1
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    1
    Remove Policy Interface Pair Filters    

    #Step 2: Test ipv6 policy
    Log    ==================== Step 1: Test ipv6 policy ====================
    Go to IPv6 policy
    View By Interface Pair View
    ####Set Filter Text For Interface Pair####
    ${filter}=    Create Dictionary    operator=Regex    from=.*${FW_TEST_INTF_2}    to=${FW_TEST_INTF_1}    set_method=text
    Set Policy Interface Pair Filter    6    &{filter}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    3
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    1
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_1}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    any    NO
    Remove Policy Interface Pair Filters
    ####Set Filter Text For Interface Pair####
    ${filter}=    Create Dictionary    operator=Contains    from=${sslvpn_intf}    to=${FW_TEST_INTF_1}    set_method=list
    Set Policy Interface Pair Filter    6    &{filter}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    any    NO
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    any    NO
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_1}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    1
    Remove Policy Interface Pair Filters
    Logout FortiGate
 
*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
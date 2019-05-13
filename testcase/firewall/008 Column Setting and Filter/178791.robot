*** Settings ***
Documentation    Verify filter is working on  Section view
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${sslvpn_intf}    SSL-VPN tunnel interface (ssl.${FW_TEST_VDOM_NAME_1})

*** Test Cases ***
178791
    [Documentation]    
    [Tags]    chrome    178791    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Step 1: Test ipv4 policy
    Log    ==================== Step 1: Test ipv4 policy ====================
    Go to policy and objects
    Go to IPv4 policy
    View By Interface Pair View
    ####Set filter for ID####
    ${filter_dict1}=    Create Dictionary     filter_type=number    operator=\=    value=${FW_TEST_V4_POLICY_ID_2}    set_method=text
    Set Policy Column Filter    ID    4    &{filter_dict1}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    1/2
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    any    NO
    Remove Policy Column Filters    ID
    ####Set filter for Name####
    ${filter_dict2}=    Create Dictionary     filter_type=string    operator=Does Not Contain    value=178791_1    set_method=text
    Set Policy Column Filter    Name    4    &{filter_dict2}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    2
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    1
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    1
    Remove Policy Column Filters    Name
    ####Set filter for Source####
    ${filter_dict3}=    Create Dictionary     filter_type=string    operator=Contains    value=ipsec_range    set_method=list
    Set Policy Column Filter    Source    4    &{filter_dict3}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    any    NO
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    1
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    any    NO
    Remove Policy Column Filters    Source
    ####Set filter for Destination####
    ${filter_dict4}=    Create Dictionary     filter_type=string    operator=Regex    value=.*bot    set_method=text
    Set Policy Column Filter    Destination    4    &{filter_dict4}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    1/2
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    1
    Remove Policy Column Filters    Destination

    #Step 2: Test ipv6 policy
    Log    ==================== Step 2: Test ipv6 policy ====================
    Go to policy and objects
    Go to IPv6 policy
    View By Interface Pair View
   ####Set filter for ID####
    ${filter_dict1}=    Create Dictionary     filter_type=number    operator=\=    value=${FW_TEST_V6_POLICY_ID_2}    set_method=text
    Set Policy Column Filter    ID    6    &{filter_dict1}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    1/2
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    any    NO
    Remove Policy Column Filters    ID
    ####Set filter for Name####
    ${filter_dict2}=    Create Dictionary     filter_type=string    operator=Does Not Contain    value=178791_6_1    set_method=text
    Set Policy Column Filter    Name    6    &{filter_dict2}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    2
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    1
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    1
    Remove Policy Column Filters    Name
    ####Set filter for Source####
    ${filter_dict3}=    Create Dictionary     filter_type=string    operator=Contains    value=ipsec_range_6    set_method=list
    Set Policy Column Filter    Source    6    &{filter_dict3}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    any    NO
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    1
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    any    NO
    Remove Policy Column Filters    Source
    ####Set filter for Destination Address####
    ${filter_dict4}=    Create Dictionary     filter_type=string    operator=Regex    value=.*bot    set_method=text
    Set Policy Column Filter    Destination Address    6    &{filter_dict4}
    Check Policy Exists or Not in Interface Pair View    ${FW_TEST_INTF_2}    ${FW_TEST_INTF_1}    1/2
    Check Policy Exists or Not in Interface Pair View    ipsec    ${FW_TEST_INTF_2}    any    NO
    Check Policy Exists or Not in Interface Pair View    ${sslvpn_intf}    ${FW_TEST_INTF_1}    1
    Remove Policy Column Filters    Destination Address
    Logout FortiGate
 
*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
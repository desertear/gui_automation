*** Settings ***
Documentation    Verify create/edit ipv6 address range (M182243)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ipv6_address_name}    768621
${ipv6_range_ori}    2000:172:16:200::1000 - 2000:172:16:200::2000
${ipv6_range_new}    2001:172:16:200::2000 - 2001:172:16:200::2001

@{ipv6_address_expected_display1}    config    IPv6 Range      ${ipv6_range_ori}
@{ipv6_address_expected_display2}    config    IPv6 Range      ${ipv6_range_new}

*** Test Cases ***
768621
    [Documentation]
    [Tags]    chrome    768621    high
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: create address range type ipv6 address
    Log    ==================== Step 1: create address range type ipv6 address ====================
    Go to Addresses
    Click Create New on Addresses List    Address
    Select Verfion on Address Editor    v6
    Input Text    ${POLICY_ADDRESSES_NAME_TEXT}    ${ipv6_address_name}
    Select From List By Value    ${POLICY_ADDRESSES_TYPE_SELECT}    string:iprange
    Wait Until Element Is Visible    ${POLICY_ADDRESSES_IP_RANGE_TEXT}
    Input Text    ${POLICY_ADDRESSES_IP_RANGE_TEXT}    ${ipv6_range_ori}
    Click Ok Button on Address Editor

    #verify ipv6 address
    @{column_list}=    Create List    Type    Details     
    ${display}=    Get Address Config by Column Name and Address Name    ${column_list}    IPv6 Address    ${ipv6_address_name}
    Should Be Equal    ${display}    ${ipv6_address_expected_display1}

# Step 2: Edit address range type ipv6 address
    Log    ==================== Step 2: Edit address range type ipv6 address ====================        
    Edit Address By Name on Address List    IPv6 Address    ${ipv6_address_name}
    Input Text    ${POLICY_ADDRESSES_IP_RANGE_TEXT}    ${ipv6_range_new}
    Click Ok Button on Address Editor

    #verify ipv6 address    
    ${display}=    Get Address Config by Column Name and Address Name    ${column_list}    IPv6 Address    ${ipv6_address_name}
    Should Be Equal    ${display}    ${ipv6_address_expected_display2}

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

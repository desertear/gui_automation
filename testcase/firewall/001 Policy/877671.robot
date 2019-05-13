*** Settings ***
Documentation    Verify tooltips and hyper link of the in duplicate firewall policies warning works (Separated from case 832185)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${dup_policy_warning_div}    xpath://div[contains(@class,"warning-message")]
${dup_policy_warning_msg}    xpath://div[contains(@class,"warning-message")]/label/span
${dup_policy_warning_item1}    xpath://div[contains(@class,"warning-message")]/label/ul/li[1]
${dup_policy_warning_item2}    xpath://div[contains(@class,"warning-message")]/label/ul/li[2]

${dup_policy_tooltip}    xpath://div[@class="base-tooltip"]//table/tbody
${var_dup_policy_warning_link}    xpath://div[contains(@class,"warning-message")]/label/ul/li/a[*/span[contains(text(),"\${PLACEHOLDER}")]]

@{ipv4_policy_in_tooltips}    Policy    test_${FW_TEST_V4_POLICY_ID_2} (${FW_TEST_V4_POLICY_ID_2}) 
...    Policy ID    ${FW_TEST_V4_POLICY_ID_2}
...    Name    test_${FW_TEST_V4_POLICY_ID_2}
...    Source    ${FW_TEST_INTF_1}
...    Destination    ${FW_TEST_INTF_2}
...    Action    DENY
...    Log    Disabled
...    Bytes

@{ipv4_policy2_in_tooltips}    Policy    test_${FW_TEST_V4_POLICY_ID_4} (${FW_TEST_V4_POLICY_ID_4})
...    Policy ID    ${FW_TEST_V4_POLICY_ID_4} 
...    Name    test_${FW_TEST_V4_POLICY_ID_4}    
...    Source    ${FW_TEST_INTF_1}
...    Destination    ${FW_TEST_INTF_2}
...    Security Profiles
...    Action    ACCEPT
...    Log    UTM
...    Bytes

@{ipv6_policy_in_tooltips}    IPv6 Policy    test_${FW_TEST_V6_POLICY_ID_2} (${FW_TEST_V6_POLICY_ID_2}) 
...    Policy ID    ${FW_TEST_V6_POLICY_ID_2} 
...    Name    test_${FW_TEST_V6_POLICY_ID_2} 
...    Source    ${FW_TEST_INTF_1}
...    Destination    ${FW_TEST_INTF_2}
...    Security Profiles
...    Action    ACCEPT
...    Log    UTM
...    Bytes

@{ipv6_policy2_in_tooltips}    IPv6 Policy    test_${FW_TEST_V6_POLICY_ID_4} (${FW_TEST_V6_POLICY_ID_4}) 
...    Policy ID    ${FW_TEST_V6_POLICY_ID_4}
...    Name    test_${FW_TEST_V6_POLICY_ID_4} 
...    Source    ${FW_TEST_INTF_1}
...    Destination    ${FW_TEST_INTF_2}
...    Action    DENY
...    Log    Disabled
...    Bytes

*** Test Cases ***
877671
    [Documentation]
    [Tags]    chrome    877671    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects


# Step 1: duplicate policy information and tooltips are displayed when policy has same srcintf, dstintf, srcaddr, dstaddr, service, and schedule
    Log    ==================== Step 1: duplicate policy information and tooltips are displayed when policy has same srcintf, dstintf, srcaddr, dstaddr, service, and schedule ====================

    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Wait Until Element Is Visible    ${dup_policy_warning_div}
    Wait Until Element Contains    ${dup_policy_warning_msg}    This policy may be a duplicate of these existing policies
    Wait Until Element Contains    ${dup_policy_warning_item1}    test_${FW_TEST_V4_POLICY_ID_2} (${FW_TEST_V4_POLICY_ID_2})        
    Wait Until Element Contains    ${dup_policy_warning_item2}    test_${FW_TEST_V4_POLICY_ID_4} (${FW_TEST_V4_POLICY_ID_4})

    Verify Display in Tooltip    ${ipv4_policy_in_tooltips}    test_${FW_TEST_V4_POLICY_ID_2}
    Verify Display in Tooltip    ${ipv4_policy2_in_tooltips}    test_${FW_TEST_V4_POLICY_ID_4}
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Wait Until Element Is Visible    ${dup_policy_warning_div}
    Wait Until Element Contains    ${dup_policy_warning_msg}    This policy may be a duplicate of these existing policies
    Wait Until Element Contains    ${dup_policy_warning_item1}    test_${FW_TEST_V6_POLICY_ID_2} (${FW_TEST_V6_POLICY_ID_2})        
    Wait Until Element Contains    ${dup_policy_warning_item2}    test_${FW_TEST_V6_POLICY_ID_4} (${FW_TEST_V6_POLICY_ID_4})   

    Verify Display in Tooltip    ${ipv6_policy_in_tooltips}    test_${FW_TEST_V6_POLICY_ID_2}
    Verify Display in Tooltip    ${ipv6_policy2_in_tooltips}    test_${FW_TEST_V6_POLICY_ID_4}
    Click Cancel Button on Policy Editor

# Step 2: verify hyper link in warning message open duplicated policy in slide in window
    Log    ==================== Step 2: verify hyper link in warning message open duplicated policy in slide in window ====================

    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    Check Click Link in Duplicate Message    ${FW_TEST_V4_POLICY_ID_1}    test_${FW_TEST_V4_POLICY_ID_1}
    Check Click Link in Duplicate Message    ${FW_TEST_V4_POLICY_ID_4}    test_${FW_TEST_V4_POLICY_ID_4}
    #because of M459036, Skip Cancel to policy list
    #Click Cancel Button on Policy Editor

    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_2}
    Check Click Link in Duplicate Message    ${FW_TEST_V6_POLICY_ID_1}    test_${FW_TEST_V6_POLICY_ID_1}
    Check Click Link in Duplicate Message    ${FW_TEST_V6_POLICY_ID_4}    test_${FW_TEST_V6_POLICY_ID_4}
    #because of M459036, Skip Cancel to policy list
    #Click Cancel Button on Policy Editor

    Logout FortiGate

*** Keywords ***
Check Click Link in Duplicate Message
    [Arguments]    ${policy_id}   ${policy_name}
    Wait Until Element Is Visible    ${dup_policy_warning_item1}
    ${duplicate_link}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_dup_policy_warning_link}    ${policy_id}
    Click Link    ${duplicate_link}
    Wait Until Element Is Visible    ${POLICY_V4V6_SLIDER_AREA}
    Wait Until Element Is Visible    ${POLICY_V4V6_SLIDER_IFRAME}
    Select Frame    ${POLICY_V4V6_SLIDER_IFRAME}
    Wait Until Element Is Visible    ${POLICY_V4V6_POLICY_COMMENT}
    Textfield Value Should Be    ${POLICY_V4V6_NAME_TEXT}    ${policy_name}
    Click Button    ${GENERAL_EDITOR_CANCEL_BUTTON}
    Wait Until Element Is Not Visible    ${POLICY_V4V6_SLIDER_AREA}
    Wait Until Element Is Not Visible    ${POLICY_V4V6_SLIDER_IFRAME}    
    Unselect Frame
    Wait Until Element Is Visible    ${dup_policy_warning_item1}

Verify Display in Tooltip
    [Arguments]   ${expect_list}    ${policy_name}
    ${duplicate_link}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${var_dup_policy_warning_link}    ${policy_name}
    Press Down Key Until an Element is Visible    ${duplicate_link}
    Mouse Over    ${duplicate_link}
    Wait Until Element Is Visible    ${dup_policy_tooltip}
    :FOR    ${line}    IN    @{expect_list}
    \    Wait Until Element Contains    ${dup_policy_tooltip}    ${line}

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

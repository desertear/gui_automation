*** Settings ***
Documentation    Verify packet capture and log can be shown correctly on GUI
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
877429
    [Documentation]    
    [Tags]    chrome    877429    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Packet Capture option can be enabled/disabled on ipv4 policy
    Log    ==================== Step 1: Packet Capture option can be enabled/disabled on ipv4 policy ====================
    Go to IPv4 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_CAPTURE_PKT_INPUT}
    Select Checkbox by JS on Policy Editor    Capture Packets    ${POLICY_V4V6_CAPTURE_PKT_ID}    ${POLICY_V4V6_CAPTURE_PKT_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    Checkbox Should Be Selected    ${POLICY_V4V6_CAPTURE_PKT_INPUT}    
    Unselect Checkbox by JS on Policy Editor    Capture Packets    ${POLICY_V4V6_CAPTURE_PKT_ID}    ${POLICY_V4V6_CAPTURE_PKT_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_CAPTURE_PKT_INPUT}
    Click Cancel Button on Policy Editor

#Step 2: Packet Capture option is not shown in deny policy on ipv4 policy
    Log    ==================== Step 2: Packet Capture option is not shown in deny policy on ipv4 policy ====================
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    Change Action to Deny on Policy Editor
    Element Should Not Be Visible     ${POLICY_V4V6_CAPTURE_PKT_INPUT}
    Element Should Not Be Visible     ${POLICY_V4V6_POLICY_LOG_H2}
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    Change Action to Accept on Policy Editor
    Element Should Be Visible     ${POLICY_V4V6_POLICY_LOG_H2}
    Select Checkbox by JS on Policy Editor    Log Allowed Traffic    ${POLICY_V4V6_LOG_ID}    ${POLICY_V4V6_LOG_INPUT}    NO
    Checkbox Should Not Be Selected    ${POLICY_V4V6_CAPTURE_PKT_INPUT}
    Click Cancel Button on Policy Editor

    #ipv6 policy does not have Capture Packet option on GUI
    
#Step 3: Can configure set log to all on ipv4 policy 
    Log    ==================== Step 3: Can configure set log to all on ipv4 policy ====================
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_3}
    Checkbox Should Be Selected    ${POLICY_V4V6_LOG_INPUT}
    Element Attribute Value Should Be    ${POLICY_V4V6_LOG_UTM_INPUT}    checked    true 
    Change Log to ALL on Policy Editor
    Click Ok Button on Policy Editor    
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_3}
    Element Attribute Value Should Be    ${POLICY_V4V6_LOG_ALL_INPUT}    checked    true
    Click Cancel Button on Policy Editor

#Step 4: check log option naming is changed in ipv4 deny policy
    Log    ==================== Step 4: check log option naming is changed in ipv4 deny policy ====================
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_3}  
    Change Action to Deny on Policy Editor
    Element Should Be Visible    ${POLICY_V4V6_POLICY_LOG_DENY_H2}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_LOG_INPUT}
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_3}
    Select Checkbox by JS on Policy Editor    NA    ${POLICY_V4V6_LOG_ID}    ${POLICY_V4V6_LOG_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_3}
    Checkbox Should Be Selected    ${POLICY_V4V6_LOG_INPUT}
    Click Cancel Button on Policy Editor

#Step 5: Can configure set log to all on ipv6 policy 
    Log    ==================== Step 3: Can configure set log to all on ipv6 policy ====================
    Go to IPv6 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_3}
    Checkbox Should Be Selected    ${POLICY_V4V6_LOG_INPUT}
    Element Attribute Value Should Be    ${POLICY_V4V6_LOG_UTM_INPUT}    checked    true 
    Change Log to ALL on Policy Editor
    Click Ok Button on Policy Editor    
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_3}
    Element Attribute Value Should Be    ${POLICY_V4V6_LOG_ALL_INPUT}    checked    true
    Click Cancel Button on Policy Editor

#Step 6: check log option naming is changed in ipv6 deny policy
    Log    ==================== Step 6: check log option naming is changed in ipv6 deny policy ====================
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_3}
    Change Action to Deny on Policy Editor
    Element Should Be Visible    ${POLICY_V4V6_POLICY_LOG_DENY_H2}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_LOG_INPUT}
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_3}
    Select Checkbox by JS on Policy Editor    NA    ${POLICY_V4V6_LOG_ID}    ${POLICY_V4V6_LOG_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_3}
    Checkbox Should Be Selected    ${POLICY_V4V6_LOG_INPUT}
    Click Cancel Button on Policy Editor

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
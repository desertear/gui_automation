*** Settings ***
Documentation    Verify policy with large ID (>10000) can be copy/paste above/after (M261925)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{column_list}    From    To    Source    Destination    Schedule    Service    Action    NAT    Security Profiles    Log
@{column_list6}    From    To    Source    Destination Address    Schedule    Service    Action    NAT    Security Profiles    Log
${policy_id_paste_above}    2
${policy_id_paste_below}    3

*** Test Cases ***
785390
    [Documentation]    
    [Tags]    chrome    785390    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Verify Copy and Paste Above/ Paste Below works on IPV4 policy
    Log    ==================== Step 1: Verify Copy and Paste Above/ Paste Below works on IPV4 policy ====================
    Go to IPv4 policy    
    View By Sequence
    Copy Policy And Paste Above    ${FW_TEST_V4_POLICY_ID_4}
    ${expect_list}=    Create List    ${policy_id_paste_above}    ${FW_TEST_V4_POLICY_ID_4}            
    Verify Policy Order by ID    ${expect_list}
    Policy Displayed on Cloumn Should be The Same    ${column_list}    ${policy_id_paste_above}    ${FW_TEST_V4_POLICY_ID_4}

    Copy Policy And Paste Below    ${FW_TEST_V4_POLICY_ID_4}
    ${expect_list}=    Create List    ${policy_id_paste_above}    ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_paste_below}
    Verify Policy Order by ID    ${expect_list}
    Policy Displayed on Cloumn Should be The Same    ${column_list}    ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_paste_below}

#Step 2: Verify Copy and Paste Above/ Paste Below works on IPV6 policy
    Log    ==================== Step 2: Verify Copy and Paste Above/ Paste Below works on IPV6 policy ====================
    Go to IPv6 policy    
    View By Sequence
    Copy Policy And Paste Above    ${FW_TEST_V6_POLICY_ID_4}
    ${expect_list}=    Create List    ${policy_id_paste_above}    ${FW_TEST_V6_POLICY_ID_4}            
    Verify Policy Order by ID    ${expect_list}
    Policy Displayed on Cloumn Should be The Same    ${column_list6}    ${policy_id_paste_above}    ${FW_TEST_V6_POLICY_ID_4}

    Copy Policy And Paste Below    ${FW_TEST_V6_POLICY_ID_4}
    ${expect_list}=    Create List    ${policy_id_paste_above}    ${FW_TEST_V6_POLICY_ID_4}    ${policy_id_paste_below}
    Verify Policy Order by ID    ${expect_list}
    Policy Displayed on Cloumn Should be The Same    ${column_list6}    ${FW_TEST_V6_POLICY_ID_4}    ${policy_id_paste_below}

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
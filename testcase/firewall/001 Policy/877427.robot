*** Settings ***
Documentation    Verify policy with large ID (>10000) can be move by drag and drop (separate from case 785390)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables *** 
${policy_id_1}    11
${policy_id_2}    22
${policy_id_3}    33
${policy_id_4}    44

*** Test Cases ***
877427
    [Documentation]    
    [Tags]    chrome    877427    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Test Move ipv4 Policy works
    Log    ==================== Step 1: Test Move ipv4 Policy works ====================
    Go to IPv4 policy    
    View By Sequence
    #move to first position
    Drag And Drop Policy    ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_1}    
    ${expect_list}=    Create List    ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_1}    ${policy_id_2}    ${policy_id_3}    ${policy_id_4}
    Verify Policy Order by ID    ${expect_list}        
    #move to last position
    Drag And Drop Policy    ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_4}    
    ${expect_list}=    Create List    ${policy_id_1}    ${policy_id_2}    ${policy_id_3}    ${policy_id_4}    ${FW_TEST_V4_POLICY_ID_4}
    Verify Policy Order by ID    ${expect_list}
    #move to middle position
    Drag And Drop Policy    ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_2}    
    ${expect_list}=    Create List    ${policy_id_1}     ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_2}    ${policy_id_3}    ${policy_id_4}
    Verify Policy Order by ID    ${expect_list}

#Step 2: Test Move ipv6 Policy works
    Log    ==================== Step 1: Test Move ipv6 Policy works ====================
    Go to IPv6 policy    
    View By Sequence
    #move to first position
    Drag And Drop Policy    ${FW_TEST_V6_POLICY_ID_4}    ${policy_id_1}    
    ${expect_list}=    Create List    ${FW_TEST_V6_POLICY_ID_4}    ${policy_id_1}    ${policy_id_2}    ${policy_id_3}    ${policy_id_4}
    Verify Policy Order by ID    ${expect_list}        
    #move to last position
    Drag And Drop Policy    ${FW_TEST_V6_POLICY_ID_4}    ${policy_id_4}    
    ${expect_list}=    Create List    ${policy_id_1}    ${policy_id_2}    ${policy_id_3}    ${policy_id_4}    ${FW_TEST_V6_POLICY_ID_4}
    Verify Policy Order by ID    ${expect_list}
    #move to middle position
    Drag And Drop Policy    ${FW_TEST_V6_POLICY_ID_4}    ${policy_id_2}    
    ${expect_list}=    Create List    ${policy_id_1}    ${FW_TEST_V6_POLICY_ID_4}     ${policy_id_2}     ${policy_id_3}    ${policy_id_4}
    Verify Policy Order by ID    ${expect_list}

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
*** Settings ***
Documentation    Verify policy with large ID (>10000) can be insert above/after 
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{column_list_empty_policy}    From    To    Source    Destination    Schedule    Service    Action    NAT
@{column_list6_empty_policy}    From    To    Source    Destination Address    Schedule    Service    Action    NAT
@{column_list_no_copy}    Security Profiles    Log 
${policy_id_insert_above}    2
${policy_id_insert_below}    3

*** Test Cases ***
877426
    [Documentation]    
    [Tags]    chrome    877426    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Verify Insert Empty Policy Above/ Paste Below can work
    Log    ==================== Step 1: Verify Insert Empty Policy Above/ Paste Below can work ====================
    Go to IPv4 policy    
    View By Sequence
    Insert Empty Policy Above    ${FW_TEST_V4_POLICY_ID_4}
    ${expect_list}=    Create List    ${policy_id_insert_above}    ${FW_TEST_V4_POLICY_ID_4}
    Verify Policy Order by ID    ${expect_list}
    Policy Displayed on Cloumn Should be The Same    ${column_list_empty_policy}    ${policy_id_insert_above}    ${FW_TEST_V4_POLICY_ID_4}
    ${config_list_1}=    Get Policy Config by Column Name and Policy ID    ${column_list_no_copy}    ${policy_id_insert_above} 

    Insert Empty Policy Below    ${FW_TEST_V4_POLICY_ID_4}
    ${expect_list}=    Create List    ${policy_id_insert_above}    ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_insert_below}
    Verify Policy Order by ID    ${expect_list}
    Policy Displayed on Cloumn Should be The Same    ${column_list_empty_policy}    ${FW_TEST_V4_POLICY_ID_4}    ${policy_id_insert_below}
    ${config_list_2}=    Get Policy Config by Column Name and Policy ID    ${column_list_no_copy}    ${policy_id_insert_below} 

    #empty policy should have no utm profile and only log utm
    ${expect_config_list}=    Create List    config    ${FW_TEST_SSL_SSH_PROFILE_DEFAULT}    UTM
    Lists Should Be Equal    ${config_list_1}    ${expect_config_list}
    Lists Should Be Equal    ${config_list_2}    ${expect_config_list}

    Go to IPv6 policy    
    View By Sequence
    Insert Empty Policy Above    ${FW_TEST_V6_POLICY_ID_4}
    ${expect_list}=    Create List    ${policy_id_insert_above}    ${FW_TEST_V6_POLICY_ID_4}     
    Verify Policy Order by ID    ${expect_list}
    Policy Displayed on Cloumn Should be The Same    ${column_list6_empty_policy}    ${policy_id_insert_above}    ${FW_TEST_V6_POLICY_ID_4}
    ${config_list_1}=    Get Policy Config by Column Name and Policy ID    ${column_list_no_copy}    ${policy_id_insert_above} 

    Insert Empty Policy Below    ${FW_TEST_V6_POLICY_ID_4}
    ${expect_list}=    Create List     ${policy_id_insert_above}    ${FW_TEST_V6_POLICY_ID_4}    ${policy_id_insert_below}
    Verify Policy Order by ID    ${expect_list}
    Policy Displayed on Cloumn Should be The Same    ${column_list6_empty_policy}    ${FW_TEST_V6_POLICY_ID_4}    ${policy_id_insert_below}
    ${config_list_2}=    Get Policy Config by Column Name and Policy ID    ${column_list_no_copy}    ${policy_id_insert_below} 

    #empty policy should have no utm profile and only log utm
    ${expect_config_list}=    Create List    config    ${FW_TEST_SSL_SSH_PROFILE_DEFAULT}    UTM
    Lists Should Be Equal    ${config_list_1}    ${expect_config_list}
    Lists Should Be Equal    ${config_list_2}    ${expect_config_list}  

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
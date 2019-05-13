*** Settings ***
Documentation    Verify policy name is mandatory and unique per vdom when configuring from the GUI (M269948)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${policy_name_1}    policy name 123
${policy_name_2}    policy name abc

${duplicate_name_err_msg}    xpath://label[contains(text(),"Duplicate entry found")]

*** Test Cases ***
794675
    [Documentation]
    [Tags]    chrome    794675    Critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: Should not allow two policies using same name in a VDOM
    Log    ==================== Step 1: Should not allow two policies using same name in a VDOM ====================
    #Test ipv4 policy
    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name_1}
    Click Ok Button on Policy Editor
    ${policy_name_1_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_IN_TABLE}    ${policy_name_1}
    Element Should Be Visible    ${policy_name_1_in_table}

    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name_1}    
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    Element Should Be Visible    ${duplicate_name_err_msg}    
    Click Cancel Button on Policy Editor

    #Test ipv6 policy 
    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name_2}
    Click Ok Button on Policy Editor
    ${policy_name_2_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_IN_TABLE}    ${policy_name_2}
    Element Should Be Visible    ${policy_name_2_in_table}

    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_2}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name_2}
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    Element Should Be Visible    ${duplicate_name_err_msg}      
    Click Cancel Button on Policy Editor

    #v4 and v6 policy can not use the same name
    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name_2}    
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    Element Should Be Visible    ${duplicate_name_err_msg}    
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_2}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name_1}
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    Element Should Be Visible    ${duplicate_name_err_msg}      
    Click Cancel Button on Policy Editor


    #Test shaping policy
    Go to Shaping policy
    Edit Shaping Policy By ID    ${FW_TEST_SHAPING_POLICY_ID_1}
    input text    ${POLICY_SHAPING_NAME_TEXT}    ${policy_name_1}
    Click Ok Button on Policy Editor
    ${policy_name_1_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SHAPING_IN_TABLE}    ${policy_name_1}
    Element Should Be Visible    ${policy_name_1_in_table}

    Edit Shaping Policy By ID    ${FW_TEST_SHAPING_POLICY_ID_2}
    input text    ${POLICY_SHAPING_NAME_TEXT}    ${policy_name_1}
    click button    ${GENERAL_EDITOR_OK_BUTTON}
    Element Should Be Visible    ${duplicate_name_err_msg}
    Click Cancel Button on Policy Editor

# Step 2: Should allow two policies from different VDOM using same name
    Log    ==================== Step 2: Should allow two policies from different VDOM using same name ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_2}   ${FW_TEST_VDOM_NAME_1}   
    Go to policy and objects

    #Test ipv4 policy
    Go to IPv4 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name_1}
    Click Ok Button on Policy Editor
    ${policy_name_1_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_IN_TABLE}    ${policy_name_1}
    Element Should Be Visible    ${policy_name_1_in_table}

    #Test ipv6 policy   
    Go to IPv6 policy
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    input text    ${POLICY_V4V6_NAME_TEXT}    ${policy_name_2}
    Click Ok Button on Policy Editor
    ${policy_name_1_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_IN_TABLE}    ${policy_name_2}
    Element Should Be Visible    ${policy_name_1_in_table}

    #Test shaping policy
    Go to Shaping policy
    Edit Shaping Policy By ID    ${FW_TEST_SHAPING_POLICY_ID_1}
    input text    ${POLICY_SHAPING_NAME_TEXT}    ${policy_name_1}
    Click Ok Button on Policy Editor
    ${policy_name_1_in_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_SHAPING_IN_TABLE}    ${policy_name_1}
    Element Should Be Visible    ${policy_name_1_in_table}

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

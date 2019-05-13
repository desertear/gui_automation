*** Settings ***
Documentation    Verify interface 'any' always at the bottom of list on policy create/edit dialog (M277368)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
801016
    [Documentation]    
    [Tags]    chrome    801016    medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Interface 'any' is displayed at the bottom when edit a policy 
    Log    ==================== Step 1: Interface 'any' is displayed at the bottom when edit a policy ====================
    Go to IPv4 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Verify Any Interface is dispalyed at Bottom
    Click Cancel Button on Policy Editor 

    Go to IPv6 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Verify Any Interface is dispalyed at Bottom
    Click Cancel Button on Policy Editor

#Step 2: Interface 'any' is displayed at the bottom when create a new policy 
    Log    ==================== Step 2: Interface 'any' is displayed at the bottom when create a new policy ====================
    Go to IPv4 policy
    Click Create New Button on Policy List
    Verify Any Interface is dispalyed at Bottom
    Click Cancel Button on Policy Editor 

    Go to IPv6 policy
    Click Create New Button on Policy List
    Verify Any Interface is dispalyed at Bottom
    Click Cancel Button on Policy Editor

    Logout FortiGate

*** Keywords ***
Verify Any Interface is dispalyed at Bottom
    Verify Incoming Interface Selection Pane
    sleep    2
    Verify Outgoing Interface Selection Pane

Verify Incoming Interface Selection Pane
    Click Element    ${POLICY_V4V6_INCOMING_INTERFACE_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_LIST}
    Wait Until Element Contains    ${POLICY_V4V6_SELECTION_PANE_LIST_LAST_ITEM}    ${FW_TEST_INTF_ANY}
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON} 

Verify Outgoing Interface Selection Pane
    Click Element    ${POLICY_V4V6_OUTGOING_INTERFACE_DIV}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_H1}
    Wait Until Element Is Visible    ${POLICY_V4V6_SELECTION_PANE_LIST}
    Wait Until Element Contains    ${POLICY_V4V6_SELECTION_PANE_LIST_LAST_ITEM}    ${FW_TEST_INTF_ANY}
    click button    ${POLICY_V4V6_ENTRY_CLOSE_BUTTON}


case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
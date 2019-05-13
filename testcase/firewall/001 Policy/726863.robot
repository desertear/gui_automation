*** Settings ***
Documentation    Verify Local in policy is displayed on GUI when set gui-local-in-policy is enabled and this setting is per vdom
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
726863
    [Documentation]    
    [Tags]    chrome    726863    medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Local in policy is shown when gui-local-in-policy is enabled.
    Log    ==================== Step 1: Local in policy is shown when gui-local-in-policy is enabled. ====================
    Element Should Be Visible    ${MENU_POLICY_LOCAL_IN_POLICY}
    Go to Local In Policy
    Element Should Be Visible    ${POLICY_LOCAL_IN_TABLE_APP}
    Unselect Frame

#Step 2: Local in policy is hidden when gui-local-in-policy is disabled.
    Log    ==================== Step 2: Local in policy is hidden when gui-local-in-policy is disabled. ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_1.txt
    Reload Page
    Element Should Not Be Visible    ${MENU_POLICY_LOCAL_IN_POLICY}

#Step 3: Local in policy is shown when gui-local-in-policy is reenabled.
    Log    ==================== Step 3: Local in policy is shown when gui-local-in-policy is reenabled. ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_2.txt
    Reload Page
    Go to Local In Policy
    Element Should Be Visible    ${POLICY_LOCAL_IN_TABLE_APP}
    Unselect Frame

#Step 4: Local in policy is not shown in another vdom.
    Log    ==================== Step 4: Local in policy is not shown in another vdom. ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_2}    ${FW_TEST_VDOM_NAME_1}    
    Go to policy and objects
    Element Should Not Be Visible    ${MENU_POLICY_LOCAL_IN_POLICY}       

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
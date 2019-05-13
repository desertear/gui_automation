*** Settings ***
Documentation    Verify multicast policy is displayed on GUI when gui-multicast-policy is enabled(Separate from case 743633)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
877338
    [Documentation]    
    [Tags]    chrome    877338    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Multicast policy is shown when gui-multicast-display is enabled.
    Log    ==================== Step 1: Multicast policy is shown when gui-multicast-display is enabled. ====================
    Element Should Be Visible    ${MENU_POLICY_MULTICAST_POLICY}
    Go to Multicast policy
    Element Should Be Visible    ${POLICY_MULTICAST_TABLE_PROTOCOL}

#Step 2: Multicast policy is hidden when gui-multicast-display is disabled.
    Log    ==================== Step 2: Multicast policy is hidden when gui-multicast-display is disabled. ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_1.txt
    Reload Page
    Element Should Not Be Visible    ${MENU_POLICY_MULTICAST_POLICY}

#Step 3: Multicast policy is shown when gui-multicast-display is reenabled.
    Log    ==================== Step 3: Multicast policy is shown when gui-multicast-display is reenabled. ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_2.txt
    Reload Page
    Go to Multicast policy
    Element Should Be Visible    ${POLICY_MULTICAST_TABLE_PROTOCOL}

#Step 4: Multicast policy is not shown in another vdom.
    Log    ==================== Step 4: Multicast policy is not shown in another vdom. ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_2}    ${FW_TEST_VDOM_NAME_1}    
    Go to policy and objects
    Element Should Not Be Visible    ${MENU_POLICY_MULTICAST_POLICY}   

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
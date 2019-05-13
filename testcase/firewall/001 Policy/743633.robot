*** Settings ***
Documentation    Verify implicit policy is displayed on GUI when gui-implicit-display is enabled
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

${implicit_policy_id}    0

*** Test Cases ***
743633
    [Documentation]    
    [Tags]    chrome    743633    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: implicit policy is shown when gui-implicit-display is enabled
    Log    ==================== Step 1: implicit policy is shown when gui-implicit-display is enabled ====================
    Go to IPv4 policy
    Check Policy Exists or Not by ID    ${implicit_policy_id}    YES
    Go to IPv6 policy
    Check Policy Exists or Not by ID    ${implicit_policy_id}    YES

#Step 2: implicit policy is hidden when gui-implicit-display is disabled.
    Log    ==================== Step 2: implicit policy is hidden when gui-implicit-display is disabled. ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_1.txt    
    Reload Page
    Go to IPv4 policy
    Check Policy Exists or Not by ID    ${implicit_policy_id}    NO
    Go to IPv6 policy
    Check Policy Exists or Not by ID    ${implicit_policy_id}    NO

#Step 3: implicit policy is shown when gui-implicit-display is reenabled
    Log    ==================== Step 3: implicit policy is shown when gui-implicit-display is reenabled. ====================
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli_2.txt
    Reload Page
    Go to IPv4 policy
    Check Policy Exists or Not by ID    ${implicit_policy_id}    YES
    Go to IPv6 policy
    Check Policy Exists or Not by ID    ${implicit_policy_id}    YES


#Step 4: implicit policy is not shown in another vdom.
    Log    ==================== Step 4: implicit policy is not shown in another vdom. ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_2}    ${FW_TEST_VDOM_NAME_1}    
    Go to policy and objects
    Go to IPv4 policy
    Check Policy Exists or Not by ID    ${implicit_policy_id}    NO
    Go to IPv6 policy
    Check Policy Exists or Not by ID    ${implicit_policy_id}    NO

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
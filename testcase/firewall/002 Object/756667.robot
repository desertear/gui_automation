*** Settings ***
Documentation    Verify proxy-options only exist in proxy vdom before 6.2 and exist in all mode after 6.2 (0492822)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
756667
    [Documentation]
    [Tags]    chrome    756667    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    ${proxy_option_label_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LABEL}    Protocol Options
    ${proxy_option_selection_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_SELECTION}    Protocol Options
    Set Suite Variable    ${Proxy_Option_Label}    ${proxy_option_label_locator}    
    Set Suite Variable    ${Proxy_Option_Selection}    ${proxy_option_selection_locator}

# Step 1: protocol option is shown when create a new policy
    Log    ==================== Step 1: protocol option is shown when create a new policy ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
    Go to IPv4 policy
    Click Create New Button on Policy List
    Proxy Option Should Be Visible
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    Click Create New Button on Policy List
    Proxy Option Should Be Visible
    Click Cancel Button on Policy Editor

# Step 2: protocol option is shown in a policy when utm inspection mode is default (flow)
    Log    ==================== Step 2: protocol option is shown in a policy when utm inspection mode is default (flow) ====================
    Go to IPv4 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Proxy Option Should Be Visible
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Proxy Option Should Be Visible
    Click Cancel Button on Policy Editor

# Step 3: protocol option is shown in a policy when utm inspection mode is proxy
    Log    ==================== Step 2: protocol option is shown in a policy when utm inspection mode is proxy ====================
    Go to IPv4 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    Proxy Option Should Be Visible
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_2}
    Proxy Option Should Be Visible
    Click Cancel Button on Policy Editor    

    Logout FortiGate

*** Keywords ***
Proxy Option Should Not Be Visible
    Element Should Not be Visible    ${Proxy_Option_Label}    
    Element Should Not be Visible    ${Proxy_Option_Selection}

Proxy Option Should Be Visible
    Element Should be Visible    ${Proxy_Option_Label}    
    Element Should be Visible    ${Proxy_Option_Selection}

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

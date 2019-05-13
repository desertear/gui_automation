*** Settings ***
Documentation    Verify policy name is optional when gui-allow-unnamed-policy enabled (M0280005)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${empty_name_error_dispaly}    [contains(@class,"ng-dirty") and contains(@class,"ng-invalid")]

*** Test Cases ***
798842
    [Documentation]
    [Tags]    chrome    798842    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

#Step 1: gui-allow-unnamed-policy is disabled, should shows error when no name is set
    Log    ==================== Step 1: gui-allow-unnamed-policy is disabled, should shows error when no name is set ====================
    #Test ipv4 policy
    Go to IPv4 policy
    Click Create New Button on Policy List
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_NAME_TEXT}
    ${empty_name_error_ipv4} =    Catenate    SEPARATOR=    ${POLICY_V4V6_NAME_TEXT}    ${empty_name_error_dispaly} 
    Element Should Be Visible    ${empty_name_error_ipv4}
    Click Cancel Button on Policy Editor
    
    #Test ipv6 Policy
    Go to IPv6 policy
    Click Create New Button on Policy List
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_NAME_TEXT}
    ${empty_name_error_ipv6} =    Catenate    SEPARATOR=    ${POLICY_V4V6_NAME_TEXT}    ${empty_name_error_dispaly}
    Element Should Be Visible    ${empty_name_error_ipv6}
    Click Cancel Button on Policy Editor

    #Test ipv4 shaping policy
    Go to Shaping policy
    Click Create New Button on Shaping Policy List
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_SHAPING_NAME_TEXT}
    ${empty_name_error_shaping} =    Catenate    SEPARATOR=    ${POLICY_SHAPING_NAME_TEXT}    ${empty_name_error_dispaly}
    Element Should Be Visible    ${empty_name_error_shaping}
    Click Cancel Button on Policy Editor

    #Test ipv6 shaping policy
    Go to Shaping policy
    Click Create New Button on Shaping Policy List
    Switch to IPv6 Mode
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_SHAPING_NAME_TEXT}
    ${empty_name_error_shaping} =    Catenate    SEPARATOR=    ${POLICY_SHAPING_NAME_TEXT}    ${empty_name_error_dispaly}
    Element Should Be Visible    ${empty_name_error_shaping}
    Click Cancel Button on Policy Editor

#Step 2: gui-allow-unnamed-policy is enabled, should allow no name
    Log    ==================== Step 2: gui-allow-unnamed-policy is enabled, should allow no name ====================
    #Enable gui-allow-unnamed-policy on cli
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_cli.txt
    Reload Page
    Wait Until Element Is Visible    ${MENU_POLICY_IPV4_POLICY}
    Go to policy and objects
    
    #Test ipv4 policy
    Go to IPv4 policy
    Click Create New Button on Policy List
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_NAME_TEXT}
    Element Should Not Be Visible    ${empty_name_error_ipv4}
    Click Cancel Button on Policy Editor

    #Test ipv6 policy
    Go to IPv6 policy
    Click Create New Button on Policy List
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_V4V6_NAME_TEXT}
    Element Should Not Be Visible    ${empty_name_error_ipv6}
    Click Cancel Button on Policy Editor
    
    #Test ipv4 shaping policy
    Go to Shaping policy
    Click Create New Button on Shaping Policy List
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_SHAPING_NAME_TEXT}
    Element Should Not Be Visible    ${empty_name_error_shaping}
    Click Cancel Button on Policy Editor

    #Test ipv6 shaping policy
    Go to Shaping policy
    Click Create New Button on Shaping Policy List
    Switch to IPv6 Mode
    Click Button    ${GENERAL_EDITOR_OK_BUTTON}
    Wait Until Element Is Visible    ${POLICY_SHAPING_NAME_TEXT}
    Element Should Not Be Visible    ${empty_name_error_shaping}
    Click Cancel Button on Policy Editor

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

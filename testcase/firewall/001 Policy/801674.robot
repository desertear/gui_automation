*** Settings ***
Documentation    Verify Clone Reserve work for policy entry without NAT enabled (M285315)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${clone_reverse_button}    Clone Reverse
${policy_id_clone_reverse}    3
@{column_list}    From    To    Source    Destination    Schedule    Service    Action    NAT    Security Profiles    Log
@{column_reverse_list}    To    From    Destination    Source    Schedule    Service    Action    NAT    Security Profiles    Log
@{column6_list}    From    To    Source    Destination Address    Schedule    Service    Action    NAT    Security Profiles    Log
@{column6_reverse_list}    To    From    Destination Address    Source    Schedule    Service    Action    NAT    Security Profiles    Log

*** Test Cases ***
801674
    [Documentation]    
    [Tags]    chrome    801674    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Verify Clone Reverse is not avilable when NAT is enabled in a policy 
    Log    ==================== Step 1: Verify Clone Reverse is not avilable when NAT is enabled in a policy ====================
    Go to IPv4 policy
    Right Click Policy By ID on Policy List    ${FW_TEST_V4_POLICY_ID_1}
    Clone Reverse is Hidden
    Close Context Menu on Policy List

    Go to IPv6 policy    
    Right Click Policy By ID on Policy List    ${FW_TEST_V6_POLICY_ID_1}
    Clone Reverse is Hidden
    Close Context Menu on Policy List

#Step 2: Verify Clone Reverse works on a policy 
    Log    ==================== Step 2: Verify Clone Reverse works on a policy ====================
    Go to IPv4 policy
    Clone Reverse A Policy and Verify Config    ${FW_TEST_V4_POLICY_ID_2}

    Go to IPv6 policy    
    Clone Reverse A Policy and Verify Config    ${FW_TEST_V6_POLICY_ID_2}    V6

    Logout FortiGate

*** Keywords ***
Clone Reverse is Hidden
    ${button_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_CONTEXT_MENU_BUTTON}    ${clone_reverse_button}
    Element Should Not Be Visible     ${button_locator}

Clone Reverse A Policy and Verify Config 
    [Arguments]   ${original_policy_id}    ${ip_version}=V4 
    Right Click Policy By ID on Policy List    ${original_policy_id}
    Click Button in Context Menu    ${clone_reverse_button}
    Check Policy Exists or Not by ID    ${policy_id_clone_reverse}
    ${column} =	Set Variable If	"${ip_version}" == "V4"    ${column_list}    ${column6_list} 
    ${column_reverse} =	Set Variable If	"${ip_version}" == "V4"    ${column_reverse_list}    ${column6_reverse_list} 
    ${display_1}=    Get Policy Config by Column Name and Policy ID    ${column}    ${original_policy_id}
    ${display_2}=    Get Policy Config by Column Name and Policy ID    ${column_reverse}    ${policy_id_clone_reverse}
    Lists Should Be Equal    ${display_1}    ${display_2}    

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
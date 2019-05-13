*** Settings ***
Documentation    Verify ssl-ssh-profile is a mandatory (but not for 40C) no matter what utm-inspection-mode is
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
884033
    [Documentation]
    [Tags]    chrome    884033    High
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
# Step 1: ssl profile is automatically enabled when a profile is enabled in new policy dialog
    Log    ==================== Step 1: ssl profile is automatically enabled when a profile is enabled in new policy dialog ====================
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
    Go to IPv4 policy
    Click Create New Button on Policy List
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    AntiVirus    ${POLICY_V4V6_ANTIVIRUS_ID}    ${POLICY_V4V6_ANTIVIRUS_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Web Filter    ${POLICY_V4V6_WEB_FILTER_ID}    ${POLICY_V4V6_WEB_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    DNS Filter    ${POLICY_V4V6_DNS_FILTER_ID}    ${POLICY_V4V6_DNS_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Application Control    ${POLICY_V4V6_APP_CONTROL_ID}    ${POLICY_V4V6_APP_CONTROL_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    IPS    ${POLICY_V4V6_IPS_ID}    ${POLICY_V4V6_IPS_INPUT}
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    Click Create New Button on Policy List
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    AntiVirus    ${POLICY_V4V6_ANTIVIRUS_ID}    ${POLICY_V4V6_ANTIVIRUS_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Web Filter    ${POLICY_V4V6_WEB_FILTER_ID}    ${POLICY_V4V6_WEB_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    DNS Filter    ${POLICY_V4V6_DNS_FILTER_ID}    ${POLICY_V4V6_DNS_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Application Control    ${POLICY_V4V6_APP_CONTROL_ID}    ${POLICY_V4V6_APP_CONTROL_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    IPS    ${POLICY_V4V6_IPS_ID}    ${POLICY_V4V6_IPS_INPUT}
    Click Cancel Button on Policy Editor


# Step 2: ssl profile is automatically enabled when utm-inspection-mode is default (flow)
    Log    ==================== Step 2: ssl profile is automatically enabled when utm-inspection-mode is default (flow) ====================
    Go to IPv4 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    AntiVirus    ${POLICY_V4V6_ANTIVIRUS_ID}    ${POLICY_V4V6_ANTIVIRUS_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Web Filter    ${POLICY_V4V6_WEB_FILTER_ID}    ${POLICY_V4V6_WEB_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    DNS Filter    ${POLICY_V4V6_DNS_FILTER_ID}    ${POLICY_V4V6_DNS_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Application Control    ${POLICY_V4V6_APP_CONTROL_ID}    ${POLICY_V4V6_APP_CONTROL_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    IPS    ${POLICY_V4V6_IPS_ID}    ${POLICY_V4V6_IPS_INPUT}
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    AntiVirus    ${POLICY_V4V6_ANTIVIRUS_ID}    ${POLICY_V4V6_ANTIVIRUS_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Web Filter    ${POLICY_V4V6_WEB_FILTER_ID}    ${POLICY_V4V6_WEB_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    DNS Filter    ${POLICY_V4V6_DNS_FILTER_ID}    ${POLICY_V4V6_DNS_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Application Control    ${POLICY_V4V6_APP_CONTROL_ID}    ${POLICY_V4V6_APP_CONTROL_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    IPS    ${POLICY_V4V6_IPS_ID}    ${POLICY_V4V6_IPS_INPUT}
    Click Cancel Button on Policy Editor

# Step 3: ssl profile is automatically enabled when utm-inspection-mode is proxy
    Log    ==================== Step 2: ssl profile is automatically enabled when utm-inspection-mode is proxy ====================
    Go to IPv4 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    AntiVirus    ${POLICY_V4V6_ANTIVIRUS_ID}    ${POLICY_V4V6_ANTIVIRUS_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Web Filter    ${POLICY_V4V6_WEB_FILTER_ID}    ${POLICY_V4V6_WEB_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    DNS Filter    ${POLICY_V4V6_DNS_FILTER_ID}    ${POLICY_V4V6_DNS_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Application Control    ${POLICY_V4V6_APP_CONTROL_ID}    ${POLICY_V4V6_APP_CONTROL_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    IPS    ${POLICY_V4V6_IPS_ID}    ${POLICY_V4V6_IPS_INPUT}
    Click Cancel Button on Policy Editor

    Go to IPv6 policy
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_2}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    AntiVirus    ${POLICY_V4V6_ANTIVIRUS_ID}    ${POLICY_V4V6_ANTIVIRUS_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Web Filter    ${POLICY_V4V6_WEB_FILTER_ID}    ${POLICY_V4V6_WEB_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    DNS Filter    ${POLICY_V4V6_DNS_FILTER_ID}    ${POLICY_V4V6_DNS_FILTER_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    Application Control    ${POLICY_V4V6_APP_CONTROL_ID}    ${POLICY_V4V6_APP_CONTROL_INPUT}
    SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled    IPS    ${POLICY_V4V6_IPS_ID}    ${POLICY_V4V6_IPS_INPUT}
    Click Cancel Button on Policy Editor    

    Logout FortiGate

*** Keywords ***
#change in B831. SSL Profile is set to "no-inspection" by default. 
SSL Profile Is Enabled Automatically When an UTM profile Is Enabled
    [Arguments]    ${utm_profile_name}    ${utm_profile_id}    ${utm_profile_input}
    Select Checkbox by JS on Policy Editor    ${utm_profile_name}    ${utm_profile_id}    ${utm_profile_input}    NO
    Element Attribute Value Should Be    ${POLICY_V4V6_SSL_SSH_INPUT}    checked    true
    #check ssl profile can be disabled when no utm profile is enabled
    UnSelect Checkbox by JS on Policy Editor    ${utm_profile_name}    ${utm_profile_id}    ${utm_profile_input} 
    UnSelect Checkbox by JS on Policy Editor    SSL Inspection    ${POLICY_V4V6_SSL_SSH_ID}    ${POLICY_V4V6_SSL_SSH_INPUT}

Verify SSL Inspection Profile Setting
    [Arguments]    ${selected_profile}
    ${setting_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_SELECTION}    SSL Inspection${SPACE}    
    Wait Until Element Is Visible    ${setting_locator}
    Element Should Contain    ${setting_locator}    ${selected_profile}

Config SSL Inspection Profile
    [Arguments]    ${new_profile}
    Select from List on Policy Editor
    ${setting_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_SELECTION}    SSL Inspection${SPACE}    
    Wait Until Element Is Visible    ${setting_locator}
    Click Element    ${setting_locator} 
    ${new_setting_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_ITEM}    ${new_profile}
    Click Element    ${new_setting_locator}
    Element Should Contain    ${setting_locator}    ${new_profile}    

SSL Profile Is Changed to Ceritficate Automatically When an UTM profile Is Enabled
    [Arguments]    ${utm_profile_name}    ${utm_profile_id}    ${utm_profile_input}
    Select Checkbox by JS on Policy Editor    ${utm_profile_name}    ${utm_profile_id}    ${utm_profile_input}    NO
    Verify SSL Inspection Profile Setting    ${FW_TEST_SSL_SSH_PROFILE_CERT}
    UnSelect Checkbox by JS on Policy Editor    ${utm_profile_name}    ${utm_profile_id}    ${utm_profile_input}   
    Select from List on Policy Editor    SSL Inspection${SPACE}    no-inspection


case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

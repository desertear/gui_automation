*** Settings ***
Documentation    Verify custom ffdb application can be displayed and delete on GUI (not even edit)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${custom_internet_service1}    797575_HTTP
${custom_internet_service2}    797575_FTP

@{column_list}    Direction    Number of Entries
@{service_expected_display1}    config    Destination    2
@{service_expected_display2}    config    Destination    4

*** Test Cases ***
797575
    [Documentation]
    [Tags]    chrome    797575    medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: Verify items are displayed
    Log    ==================== Step 1: Verify items are displayed ====================
    Go to Internet Service Database
    ${display}=    Get ISDB Config by Column Name and Service Name    ${column_list}    Custom Internet Service    ${custom_internet_service1}
    Should Be Equal    ${display}    ${service_expected_display1}
    ${display}=    Get ISDB Config by Column Name and Service Name    ${column_list}    Custom Internet Service    ${custom_internet_service2}
    Should Be Equal    ${display}    ${service_expected_display2}

# Step 2: Verify Edit button is not available
    Log    ==================== Step 2: Verify Edit button is not available ====================
    #Edit button on top menu is not available
    Click ISDB By Name on ISDB List    Custom Internet Service    ${custom_internet_service1}
    Wait Until Element Is Visible    ${POLICY_V4V6_EDIT_BUTTON}
    Element Should Not Be Visible    ${POLICY_V4V6_EDIT_BUTTON_E}
    #Edit button on right click menu is not available
    Right Click ISDB on ISDB List     ${custom_internet_service1}
    Element Attribute Value Should Be    ${POLICY_CONTEXT_MENU_BUTTON_EDIT}    disabled    true
    Close Context Menu on Policy Object

# Step 3: Verify custom internet service can be deleted
    Log    ==================== Step 3: Verify custom internet service can be deleted ====================
    Open Section Label on ISDB List    Custom Internet Service  
    Click ISDB By Name on ISDB List    Custom Internet Service    ${custom_internet_service1}
    Delete Policy Object By Top Menu    ISDB    ${custom_internet_service1}
    Delete Policy Object By Context Menu    ISDB    ${custom_internet_service2}
    Logout FortiGate

*** Keywords ***


case Teardown
    write test result to file    ${CURDIR}

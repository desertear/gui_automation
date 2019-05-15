*** Settings ***
Documentation   Verify messages GUI for global and vdom
Resource    ../../../system_resource.robot

*** Variables ***
${test_name}   713646
@{group_label}    Authentification    Sécurité    VPN SSL
*** Test Cases ***
713646
    [Documentation]    
    [Tags]    v6.0    chrome   713646    High    win10,64bit    system  runable  rest
    ######
    Login FortiGate  
    Go to system
    Go to system_Settings
    wait and click   ${SYSTEM_SETTINGS_VIEW_LANGUAGE_MENU}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_VIEW_LANGUAGE}   French
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_APPLY_SPAN}
    sleep  2
    Go to system_FRN
    Go to system_Replacement_Messages_FRN
    sleep  2
    select frame     ${NETWORK_FRAME}
    select frame     ${SYSTEM_RPLCE_MSG_FRAME_LIST}
    wait and click   ${SYSTEM_RPLCE_MSG_MANAGE_IMG_BUTTON}
    wait and click   ${SYSTEM_RPLCE_MSG_MANAGE_CRTNEW_BUTTON_FRN}
    Wait Until Element Is Visible    ${SYSTEM_RPLCE_MSG_MANAGE_NAME_INPUT_FRN}
    clear element text    ${SYSTEM_RPLCE_MSG_MANAGE_NAME_INPUT_FRN}
    input text       ${SYSTEM_RPLCE_MSG_MANAGE_NAME_INPUT_FRN}    ${test_name}
    Choose File      ${SYSTEM_RPLCE_MSG_MANAGE_FILE_INPUT_FRN}     ${SYSTEM_CLI_DATA_DIR}${/}replace_msg_test.png
    Wait Until Element Is Visible     ${SYSTEM_RPLCE_MSG_MANAGE_FILE_IMG}
    wait and click   ${SUBMIT_OK_BUTTON}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_RPLCE_MSG_MANAGE_ITEM}    ${test_name}
    wait and click   ${new_locator}
    wait and click   ${SYSTEM_RPLCE_MSG_MANAGE_DEL_BUTTON_FRN}
    wait and click   ${CONFIRM_OK_BUTTON}
    unselect frame
    Go to Global
    ${text_global}=   create list    
    Go to system_FRN
    Go to system_Replacement_Messages_FRN
    sleep  2
    select frame      ${NETWORK_FRAME}
    select frame      ${SYSTEM_RPLCE_MSG_FRAME_LIST}
    :FOR  ${element}  IN     @{group_label}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_RPLCE_MSG_MANAGE_GRP_LABEL}   ${element}
        \  ${text}=     get text    ${new_locator}
        \   APPEND TO LIST   ${text_global}   ${text}
    unselect frame
    Go to Global
    Go to VDOM    ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system_FRN
    Go to system_Replacement_Messages_FRN
    sleep  2
    select frame     ${NETWORK_FRAME}
    select frame     ${SYSTEM_RPLCE_MSG_FRAME_LIST}
    ${text_vdom}=    create list    
    :FOR  ${element}   IN    @{group_label}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_RPLCE_MSG_MANAGE_GRP_LABEL}   ${element}
        \  ${text}=     get text    ${new_locator}
        \   APPEND TO LIST   ${text_vdom}   ${text}
    should be equal    "${text_global}"    "${text_vdom}"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    Run Cli commands in File     ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

Go to system_FRN
    Wait Until Element Is Visible    ${SYSTEM_ENTRY_FRN}
    ${nav_bar_is_not_expanded}=    run keyword and return status    Wait Until Page Contains Element    ${SYSTEM_ENTRY}//following-sibling::f-icon[@class="fa-angle-right rotate-0"]
    run keyword if    "${nav_bar_is_not_expanded}"=="True"    click element    ${SYSTEM_ENTRY_FRN}

Go to system_Replacement_Messages_FRN
    Wait Until Element Is Visible    ${SYSTEM_RPLCE_MSG_ENTRY_FRN}
    click element    ${SYSTEM_RPLCE_MSG_ENTRY_FRN}
    sleep    2

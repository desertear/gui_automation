*** Settings ***
Documentation   Verify messages GUI for global and vdom
Resource    ../../../system_resource.robot

*** Variables ***
${test_name}   591247
@{group_label}    Authentication    Security    SSL-VPN
*** Test Cases ***
591427
    [Documentation]    
    [Tags]    v6.0    chrome   591427    High    win10,64bit    system   runable  rest
    ######
    Login FortiGate  
    Go to system
    Go to system_Replacement_Messages
    sleep  2
    select frame     ${NETWORK_FRAME}
    select frame     ${SYSTEM_RPLCE_MSG_FRAME_LIST}
    wait and click   ${SYSTEM_RPLCE_MSG_MANAGE_IMG_BUTTON}
    wait and click   ${SYSTEM_RPLCE_MSG_MANAGE_CRTNEW_BUTTON}
    Wait Until Element Is Visible    ${SYSTEM_RPLCE_MSG_MANAGE_NAME_INPUT}
    clear element text    ${SYSTEM_RPLCE_MSG_MANAGE_NAME_INPUT}
    input text       ${SYSTEM_RPLCE_MSG_MANAGE_NAME_INPUT}    ${test_name}
    Choose File      ${SYSTEM_RPLCE_MSG_MANAGE_FILE_INPUT}    ${SYSTEM_CLI_DATA_DIR}${/}replace_msg_test.png
    Wait Until Element Is Visible     ${SYSTEM_RPLCE_MSG_MANAGE_FILE_IMG}
    wait and click   ${SUBMIT_OK_BUTTON}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_RPLCE_MSG_MANAGE_ITEM}    ${test_name}
    wait and click   ${new_locator}
    wait and click   ${SYSTEM_RPLCE_MSG_MANAGE_DEL_BUTTON}
    wait and click   ${CONFIRM_OK_BUTTON}
    unselect frame
    Go to Global
    ${text_global}=   create list    
    Go to system
    Go to system_Replacement_Messages
    sleep  2
    select frame     ${NETWORK_FRAME}
    select frame     ${SYSTEM_RPLCE_MSG_FRAME_LIST}
    :FOR  ${element}   IN    @{group_label}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_RPLCE_MSG_MANAGE_GRP_LABEL}   ${element}
        \  ${text}=     get text    ${new_locator}
        \   APPEND TO LIST   ${text_global}   ${text}
    unselect frame
    Go to Global
    Go to VDOM    ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system
    Go to system_Replacement_Messages
    sleep  2
    select frame     ${NETWORK_FRAME}
    select frame     ${SYSTEM_RPLCE_MSG_FRAME_LIST}
    ${text_vdom}=    create list    
    :FOR  ${element}   IN    @{group_label}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_RPLCE_MSG_MANAGE_GRP_LABEL}   ${element}
        \  ${text}=     get text    ${new_locator}
        \   APPEND TO LIST   ${text_vdom}   ${text}
    should be equal    "${text_global}"    "${text_vdom}"
    unselect frame
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    write test result to file    ${CURDIR}


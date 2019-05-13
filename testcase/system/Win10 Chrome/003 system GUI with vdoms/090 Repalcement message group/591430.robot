*** Settings ***
Documentation   Verify messages GUI for vdom be customized
Resource    ../../../system_resource.robot

*** Variables ***
@{group_label}    Authentication    Security    SSL-VPN
${test_table}    Authentication
${test_item}     Login Page
${test_item_html}     Authentication Is Required
${edit}    id:edit_pane
${text_inside}    xpath://pre[contains(text(),"Authentication Required")]
*** Test Cases ***
591430
    [Documentation]    
    [Tags]    v6.0    chrome   591430    High    win10,64bit    system  norun  rest
    ######
    Login FortiGate  
    Go to system
    Go to system_Replacement_Messages
    sleep  2
    SELECT REPLCAEMENT MESSAGES ITEM    item_name=${test_item}    tabel_type=${test_table}    
    unselect frame
    select frame    ${NETWORK_FRAME}
    select frame    ${SYSTEM_RPLCE_MSG_FRAME_PREVIEW}
    sleep  2
    wait and click      ${text_inside}
    clear element text  ${text_inside}
    input text          ${text_inside}    ${test_item_html}
    wait and click      ${SUBMIT_SAVE_BUTTON}
    SELECT REPLCAEMENT MESSAGES ITEM    item_name=${test_item}    tabel_type=${test_table}    
    ${new_table}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_RPLCE_MSG_TABLE_NAME}         ${tabel_type}
    ${new_modify}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_RPLCE_MSG_TABLE_ITEM_MODIFY}  ${item_name}
    ${new_locator}=  CATENATE  SEPARATOR=    ${new_table}    ${new_modify}
    Wait Until Element Is Visible     ${new_locator}
    sleep   2
    wait and click    ${SUBMIT_RESTORE_BUTTON}      
    ${status}=  run keyword and return status    Wait Until Element Is Visible     ${new_locator}
    should be equal  "${status}"    "False"
    [teardown]    case teardown
    
*** Keywords ***
case teardown    
    Close All Browsers
    write test result to file    ${CURDIR}

SELECT REPLCAEMENT MESSAGES ITEM
    [Arguments]      ${item_name}    ${tabel_type}
    select frame     ${NETWORK_FRAME}
    select frame     ${SYSTEM_RPLCE_MSG_FRAME_LIST}
    ${new_table}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_RPLCE_MSG_TABLE_NAME}    ${tabel_type}
    ${new_item}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_RPLCE_MSG_TABLE_ITEM_NAME}    ${item_name}
    ${new_locator}=   CATENATE  SEPARATOR=    ${new_table}    ${new_item}
    wait and click    ${new_locator}
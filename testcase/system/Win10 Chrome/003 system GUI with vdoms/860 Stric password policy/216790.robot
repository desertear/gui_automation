*** Settings ***
Documentation    GUI:Password strength real time check
Resource    ../../../system_resource.robot

*** Variables ***
${pass_scope}   Admin
${admin_name}   216790
${length_input}    min-length
@{char_list}    min-upper    min-lower    min-special
${char_list_num}    min-number
@{vdom}      ${SYSTEM_TEST_VDOM_NAME_1}
${old_pass}    12345678
${new_pass}     123456789
*** Test Cases ***
216790
    [Documentation]    
    [Tags]    v6.0    chrome   216790    High    win10,64bit   runable    
    ######
    Login FortiGate   
    Go to Global
    Go to system
    Go to system_Settings
    wait until Element Is Visible   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    ${pass_scope}
    ${new_locator}=    CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click   ${new_locator}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_CHKBOX}
    run keyword if    "${status}"=="False"    wait and click    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_LABEL}
    :FOR  ${element}   IN   @{char_list}
         \  ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${element}
         \  clear element text    ${new_locator}
         \  input text    ${new_locator}    0
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${char_list_num}
    clear element text    ${new_locator}
    input text    ${new_locator}    1      
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${length_input}
    clear element text  ${new_locator}
       input text    ${new_locator}    8
    wait and click   ${SUBMIT_APPLY_SPAN}
    sleep   2
    go to system 
    go to System_administrators
    Create Administrator    ${admin_name}    ${old_pass}   vdom=${vdom}
    EDIT ADMINISTRATOR  ${admin_name}
    wait and click        ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_BUTTON}
    wait until element is visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}
    input text            ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OLD}    ${old_pass}
    wait until element is visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}
    input text            ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}    123
    Wait Until Element Is Visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_WARN}
    wait until element is visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}
    input text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_NEW}    ${new_pass} 
    wait until element is visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}
    input text            ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_CONFIRM}    ${new_pass} 
    Wait Until Element Is Visible    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_WARN_SPAN}
    wait and click        ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_OK_BUTTON}
    wait and click        ${SUBMIT_OK_SPAN}
    Go to system
    Go to system_Settings
    wait until Element Is Visible   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    Off
    ${new_locator}=    CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click     ${new_locator}
    wait and click     ${SUBMIT_APPLY_SPAN}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  
    Close All Browsers
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}reset_passwdpolicy_cli.txt   username=${SUPER_ADMIN_NAME}  password=${SUPER_ADMIN_PASSWD}  
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt 
    write test result to file    ${CURDIR}


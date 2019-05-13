*** Settings ***
Documentation   GUI:Verify set min-lower-case-letter/ min-upper-case-letter/ min-non-alphanumeric/ min-number works for password policy
Resource    ../../../system_resource.robot

*** Variables ***
${pass_scope}   Admin
@{char_list}    min-upper    min-lower    min-number    min-special
@{char_list_check}   Upper   Lower   Number     Special    
${length_input}    min-length
${length_check}    length
${username}        712980
${password}        123
${new_passwd}      Abc123!@#$
@{vdom}      ${SYSTEM_TEST_VDOM_NAME_1}
*** Test Cases ***
712980
    [Documentation]    
    [Tags]    v6.0    chrome   712980    High    win10,64bit     runable   
    ######
    Login FortiGate   
    Go to Global
    Go to system
    go to System_administrators
    Create Administrator   ${username}    ${password}    vdom=${vdom}
    Go to system
    Go to system_Settings
    wait until Element Is Visible   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    ${pass_scope}
    ${new_locator}=    CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click     ${new_locator}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_CHKBOX}
    run keyword if    "${status}"=="False"    wait and click    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_LABEL}
    ${i}=   set variable    1
    ${j}=   set variable    0
    :FOR  ${element}   IN   @{char_list}
         \  ${j}=    evaluate   ${i}+${j}
         \  ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${element}
         \  clear element text  ${new_locator}
         \  input text  ${new_locator}    ${i}
         \  ${i}=       evaluate   ${i}+1
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${length_input}
    clear element text  ${new_locator}
    input text    ${new_locator}    ${j}
    wait and click   ${SUBMIT_APPLY_SPAN}
    Go to Global
    Go to system
    Go to System_administrators
    EDIT ADMINISTRATOR   ${username} 
    wait and click  ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_BUTTON}
    sleep   2
    ${i}=   set variable    1
    :FOR   ${element}   IN   @{char_list_check}
        \    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_RULE}    ${element}
        \    ${num_check}=      get text    ${new_locator}
        \    should be equal   "${num_check}"    "${i}"
        \    ${i}=   evaluate   ${i}+1
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_RULE}    ${length_check}
    ${num_check}=    get text   ${new_locator}
    should be equal    "${num_check}"    "${j}"
    Logout FortiGate  
    go to Login page  
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    Run Keyword And Continue On Failure    input text    ${LOGIN_USERNAME_TEXT}    ${username}
    Run Keyword And Continue On Failure    input password    ${LOGIN_PASSWORD_TEXT}    ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_LOGIN_BUTTON}
    sleep   5
    ${i}=   set variable    1
    :FOR   ${element}   IN   @{char_list_check}
        \    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_RULE_LOGINPAGE}    ${element}
        \    ${num_check}=    get text    ${new_locator}
        \    should be equal    "${num_check}"    "${i}"
        \    ${i}=     evaluate   ${i}+1
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_RULE_LOGINPAGE}    ${length_check}
    ${num_check}=    get text    ${new_locator}
    should be equal    "${num_check}"    "${j}"
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_OLD}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_OLD}
    input text        ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_OLD}    ${password}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_NEW}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_NEW}
    input text        ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_NEW}    ${new_passwd}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_CONFIRM}
    clear element text    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_CONFIRM}
    input text        ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_CONFIRM}    ${new_passwd}
    wait and click    ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_LOGINPAGE_OK}
    Login FortiGate   username=${username}    password=${new_passwd}
    sleep   2
    Go to system
    Go to system_Settings
    wait until Element Is Visible   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    Off
    ${new_locator}=   CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click    ${new_locator}
    wait and click    ${SUBMIT_APPLY_SPAN}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  username=${username}
    Close All Browsers
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}reset_passwdpolicy_cli.txt   username=${SUPER_ADMIN_NAME}  password=${SUPER_ADMIN_PASSWD}  
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}


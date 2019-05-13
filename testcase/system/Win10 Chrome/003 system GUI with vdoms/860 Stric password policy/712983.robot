*** Settings ***
Documentation   GUI:Verify “Enable Password Expiration” for password policy
Resource    ../../../system_resource.robot

*** Variables ***
${pass_scope}   Admin
@{char_list}    min-upper    min-lower   min-special    min-number
${char_list_num}    min-number
@{char_list_check}   Upper   Lower   Special    Num
${length_input}    min-length
${length_check}    length
${username}      712983   
${password}      123
@{vdom}      ${SYSTEM_TEST_VDOM_NAME_1}
${new_passwd}    Abc1234!@#$
${passwd_chg_span}     xpath://div[span="Your password is expired, please input a new password."]
*** Test Cases ***
712983
    [Documentation]    
    [Tags]    v6.0    chrome   712983    High    win10,64bit     runable   env2fail
    ######
    Login FortiGate   
    Go to Global
    Go to system
    Go to System_administrators
    Create Administrator  username=${username}    password=${password}    vdom=${vdom}  
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
         \  ${j}=     evaluate   ${i}+${j}
         \  ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${element}
         \  clear element text  ${new_locator}
         \  input text    ${new_locator}    ${i}
         \  ${i}=       evaluate   ${i}+1
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${length_input}
    clear element text  ${new_locator}
    input text    ${new_locator}    ${j}  
    ${status}=    run keyword and return status     checkbox should be selected    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_EXPIRE_CHBX_INPUT}
    run keyword if      "${status}"=="False"     wait and click   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_EXPIRE_CHBX_LABEL}
    clear element text   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_EXPIRE_DAYS_INPUT}
    input text       ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_EXPIRE_DAYS_INPUT}    1   
    wait and click   ${SUBMIT_APPLY_SPAN}
    sleep    2
    ${time_pc}=      Get Current Date 
    ${time_day_add1}=   ADD TIME TO DATE   ${time_pc}   2 days
    ${date}=  Convert Date    ${time_day_add1}   result_format=%Y/%m/%d
    Wait Until Element Is Visible    ${system_ntp-manual settings_label}
    Click Element    ${system_ntp-manual settings_label}
    Wait Until Element Is Visible     ${system_ntp-manual settings_date}
    Clear Element Text   ${system_ntp-manual settings_date}
    input text       ${system_ntp-manual settings_date}    ${date}
    wait and click   ${SUBMIT_APPLY_SPAN}
    Close all Browsers
    go to Login page  
    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    input text        ${LOGIN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_PASSWORD_TEXT}    ${password}
    wait and click    ${LOGIN_LOGIN_BUTTON}
    sleep   5
    wait Until Element Is Visible  ${passwd_chg_span}
    ${i}=   set variable    1
    :FOR   ${element}   IN   @{char_list_check}
        \    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_RULE_LOGINPAGE}    ${element}
        \    ${num_check}=    get text    ${new_locator}
        \    should be equal    "${num_check}"    "${i}"
        \    ${i}=    evaluate   ${i}+1
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE     ${SYSTEM_ADMINISTRATORS_EDIT_ADMIN_CHANGE_PASSWORD_RULE_LOGINPAGE}    ${length_check}
    ${num_check}=     get text    ${new_locator}
    should be equal  "${num_check}"    "${j}"
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
    ###    set password policy off and set system-time to normal
    Login FortiGate   username=${username}    password=${new_passwd}
    sleep    2
    Go to system
    Go to system_Settings
    wait until Element Is Visible   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    Off
    ${new_locator}=    CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_APPLY_SPAN}
    sleep    2
    Go to system
    Go to system_Settings
    ${time_pc}=      Get Current Date 
    ${date}=  Convert Date    ${time_pc}   result_format=%Y/%m/%d
    Wait Until Element Is Visible    ${system_ntp-manual settings_label}
    Click Element    ${system_ntp-manual settings_label}
    Wait Until Element Is Visible    ${system_ntp-manual settings_date}
    Clear Element Text   ${system_ntp-manual settings_date}
    input text       ${system_ntp-manual settings_date}    ${date}
    wait and click   ${SUBMIT_APPLY_SPAN}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate    username=${username}
    Close All Browsers
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}reset_passwdpolicy_cli.txt   username=${SUPER_ADMIN_NAME}  password=${SUPER_ADMIN_PASSWD}  
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}


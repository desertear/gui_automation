*** Settings ***
Documentation    Verify GUI new admin setting page works as expected - 0306097
Resource    ../../../system_resource.robot

*** Variables ***
${admin_username}    810652
${password}    123
@{vdom}        ${SYSTEM_TEST_VDOM_NAME_1} 
${pass_scope}   Admin
@{char_list}    min-upper    min-lower    min-number    min-special
*** Test Cases ***
810652
    [Documentation]    
    [Tags]    v6.0    chrome   810652    Critical    win10,64bit   runable
    Login FortiGate  
    sleep  2
    Go to system
    Go to System_administrators
    Create Administrator  username=${admin_username}     password=${password}     vdom=${vdom}
    logout FortiGate  
    Login FortiGate   username=${admin_username}    password=${password}
    sleep  2
    Go to system
    Go to system_Settings
    wait and click   ${SYSTEM_SETTINGS_ADMIN_SSH_PORT_INPUT}
    ${text}=    get element attribute   ${SYSTEM_SETTINGS_ADMIN_SSH_PORT_INPUT}    value
    wait and click    ${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_INPUT}
    ${text_old}=    get element attribute   ${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_INPUT}    value
    clear element text    ${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_INPUT}
    input text    ${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_INPUT}    ${text}
    wait and click   ${SYSTEM_SETTINGS_ADMIN_SSH_PORT_INPUT}
    Wait Until Element Is Visible   ${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_CONFILCT_WARN}
    clear element text    ${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_INPUT}
    input text    ${SYSTEM_SETTINGS_ADMIN_TELNET_PORT_INPUT}    ${text_old}
    wait until Element Is Visible   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    ${pass_scope}
    ${new_locator}=    CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click   ${new_locator}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_CHKBOX}
    run keyword if    "${status}"=="False"    wait and click    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_LABEL}
    ${i}=   set variable    0
    :FOR  ${element}   IN   @{char_list}
         \  ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${element}
         \  clear element text    ${new_locator}
         \  input text    ${new_locator}    ${i}
         \  ${i}=     evaluate   ${i}+1
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_REUSE_CHKBX}
    run keyword if    "${status}"=="True"    wait and click   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_REUSE_LABEL}
    wait and click   ${SUBMIT_APPLY_SPAN}
    go to system
    Go to system_Settings
    Wait Until Element Is Visible    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_MIN_LENTH}
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_CHKBOX}
    run keyword if    "${status}"=="False"    wait and click    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ_LABEL}
    ${i}=   set variable    0
    :FOR  ${element}   IN   @{char_list}
         \  ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${element}
         \  ${value}=    get element attribute     ${new_locator}    value
         \  should be equal   "${value}"    "${i}"
         \  ${i}=     evaluate   ${i}+1
    ${status}=    run keyword and return status    checkbox should be selected    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_REUSE_CHKBX}
    should be equal   "${status}"    "False"
    run keyword if    "${status}"=="False"    wait and click   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_REUSE_LABEL}
    sleep   1
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    Off
    ${new_locator}=    CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_APPLY_SPAN}
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate   username=${admin_username}
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}


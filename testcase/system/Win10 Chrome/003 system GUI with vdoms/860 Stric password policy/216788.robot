*** Settings ***
Documentation   GUI can show and fill for password policy configuration
Resource    ../../../system_resource.robot

*** Variables ***
${pass_scope}   Admin
@{char_list}    min-upper    min-lower    min-number    min-special
*** Test Cases ***
216788
    [Documentation]    
    [Tags]    v6.0    chrome   216788    High    win10,64bit    runable  
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
    ${i}=   set variable    0
    :FOR  ${element}   IN   @{char_list}
         \  ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_CHAR_REQ}    ${element}
         \  clear element text    ${new_locator}
         \  input text    ${new_locator}    ${i}
         \  ${i}=     evaluate   ${i}+1
    wait and click   ${SUBMIT_APPLY_SPAN}
    sleep    2
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
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION_SCOPE_LABEL}    Off
    ${new_locator}=    CATENATE     SEPARATOR=     ${SYSTEM_SETTINGS_PASSWDPLCY_SECTION}    ${new_locator}
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_APPLY_SPAN}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}reset_passwdpolicy_cli.txt   username=${SUPER_ADMIN_NAME}  password=${SUPER_ADMIN_PASSWD}  
    write test result to file    ${CURDIR}


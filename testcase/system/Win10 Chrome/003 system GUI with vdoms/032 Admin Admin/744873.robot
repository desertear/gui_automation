*** Settings ***
Documentation    Verify admin-lockout-threshold function works for GUI login
Resource    ../../../system_resource.robot

*** Variables ***
${username}     admin
${password1}    1
${password2}    2
${admin_lock_message}       xpath://div[contains(text(),"Too many login failures. Please try again in a few minutes")]
*** Test Cases ***
744873
    [Documentation]    
    [Tags]    v6.0    chrome   744873    High    win10,64bit   runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    go to Login page      
    sleep   2
    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    clear element text    ${LOGIN_USERNAME_TEXT}
    input text        ${LOGIN_USERNAME_TEXT}    ${username}
    clear element text    ${LOGIN_PASSWORD_TEXT}    
    input password    ${LOGIN_PASSWORD_TEXT}    ${password2}
    click button      ${LOGIN_LOGIN_BUTTON}
    sleep    2
    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    clear element text    ${LOGIN_USERNAME_TEXT}
    input text        ${LOGIN_USERNAME_TEXT}    ${username}
    clear element text    ${LOGIN_PASSWORD_TEXT}    
    input password    ${LOGIN_PASSWORD_TEXT}    ${password2}
    click button      ${LOGIN_LOGIN_BUTTON}
    Wait Until Element Is Visible     ${admin_lock_message}
    sleep   60
    Login FortiGate 
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}


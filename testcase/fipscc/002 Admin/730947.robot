*** Settings ***
Documentation    Verify failed user login limit with lockout
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${browser}    Chrome
${url}    ${FGT_URL}
${logout_message}    You have logged out. It is recommended to close the window for security reasons.
${duration}    30
${threshold}   4
${username}    ${FGT_GUI_USERNAME}
${password1}    zj#12345
${password2}    Zj!12345
${password3}    j#12345
${password4}    Zj#123456
${password}    ${FGT_GUI_PASSWORD}
*** Test Cases ***
730947
    [Documentation]   
    [Tags]    chrome    730947    critical
    [setup]    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    ##Login FGT
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    #input wrong password
    input text    ${LOGIN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_PASSWORD_TEXT}    ${password1}
    click button    ${LOGIN_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${LOGIN_AUTH_FAILURE}
    #input wrong password
    input text    ${LOGIN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_PASSWORD_TEXT}    ${password2}
    click button    ${LOGIN_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${LOGIN_AUTH_FAILURE}
    #input wrong password
    input text    ${LOGIN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_PASSWORD_TEXT}    ${password3}
    click button    ${LOGIN_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${LOGIN_AUTH_FAILURE}
    #input wrong password
    input text    ${LOGIN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_PASSWORD_TEXT}    ${password4}
    click button    ${LOGIN_LOGIN_BUTTON}
    Wait Until Element Is Visible    ${LOGIN_LOCKOUT_WARNING}
    Close Browser
    ${wait_time}=    evaluate    ${duration}+2
    sleep    ${wait_time}
    #input correct password
    Login FortiGate
    ##Logout FGT
    Logout FortiGate


*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${FIPSCC_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
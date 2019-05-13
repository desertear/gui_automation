*** Settings ***
Documentation    Verify that valid local user can login sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
${url}    ${SSLVPN_URL}
${browser}    ${SSLVPN_BROWSER}
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}

*** Test Cases ***
862565
    [Tags]    v6.0    firefox    chrome    edge    safari    862565    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt

    Open Browser    ${url}    browser=${browser}
    Run Keyword And Continue On Failure    Maximize Browser Window
    Run Keyword And Continue On Failure    get all selenium config
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${LOGIN_SSLVPN_USERNAME_TEXT}
    Run Keyword And Continue On Failure    input text    ${LOGIN_SSLVPN_USERNAME_TEXT}    ${username}
    Run Keyword And Continue On Failure    input password    ${LOGIN_SSLVPN_PASSWORD_TEXT}    ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_SSLVPN_LOGIN_BUTTON}
    #Verify login blocked by host check
    Run keyword And Continue On Failure    Wait Until Element Is Visible    ${HOST_CHECK_WARNING}
    Run Keyword And Continue On Failure    click element    ${HOST_CHECK_OK_BUTTON}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
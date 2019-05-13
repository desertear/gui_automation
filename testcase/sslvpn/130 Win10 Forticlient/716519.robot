*** Settings ***
Documentation    Suite description
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot


*** Variables ***
${profile}    sslvpn_automation_pki
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}

*** Test Cases ***
716519
    [Tags]    win10    v6.0    v6.2    716519    screen_alive    forticlient_6.0.3.0155
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    open forticlient and select profile    ${profile}
    connect sslvpn on forticlient

    [Teardown]    case Teardown
*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
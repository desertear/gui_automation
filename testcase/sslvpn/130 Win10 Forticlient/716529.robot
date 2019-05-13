*** Settings ***
Documentation    Suite description
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_certificate

*** Test Cases ***
716529
    [Tags]    win10   v6.0    v6.2    716529    screen_alive    forticlient_6.0.3.0155
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    logout sslvpn on forticlient
    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
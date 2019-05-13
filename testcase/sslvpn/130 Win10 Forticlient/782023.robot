*** Settings ***
Documentation   Verify windows forticlient working when limit-user-logins enabled in sslvpn portal.
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${cmd}     ping 172.16.200.55

*** Test Cases ***
782023
    [Tags]    win10   v6.0    v6.2    782023    screen_alive    forticlient_6.0.3.0155
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Set Library Search Order    SeleniumLibrary    SikuliLibrary
    #login sslvpn web portal
    Login SSLVPN Portal
    #login sslvpn with forticlient
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn with limit user login

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
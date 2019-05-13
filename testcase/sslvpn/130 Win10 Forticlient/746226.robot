*** Settings ***
Documentation    Verify windows forticlient can get option of save-password from FGT.

Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${option}    save_password

*** Test Cases ***
746226
    [Tags]    win10    v6.0    v6.2    746226    screen_alive    forticlient_6.0.3.0155
    #Config SSLVPN ON CLI
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    logout sslvpn on forticlient

    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    check client option   ${option}
    connect sslvpn on forticlient
    logout sslvpn on forticlient

    open forticlient and select profile    ${profile}
    connect sslvpn on forticlient
    logout sslvpn on forticlient
    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    Logout SSLVPN Portal
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    run keyword and ignore error    open forticlient and select profile    ${profile}
    run keyword and ignore error    uncheck client option    ${option}
    run keyword and ignore error    connect sslvpn on forticlient
    run keyword and ignore error    logout sslvpn on forticlient
    open forticlient and select profile    ${profile}
    reset forticlient profile
    write test result to file    ${CURDIR}
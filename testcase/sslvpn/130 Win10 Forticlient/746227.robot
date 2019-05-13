*** Settings ***
Documentation    Verify windows forticlient can get option of keep-alive from FGT.

Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${option}    always_up

*** Test Cases ***
746227
    [Tags]    win10    v6.0    v6.2    746227    screen_alive    forticlient_6.0.3.0155
    #Config SSLVPN ON CLI
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    #connect to sslvpn
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    logout sslvpn on forticlient

    #forticlient will show alway_up and save password option, select the option and connect again
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    check client option   ${option}
    connect sslvpn on forticlient
    logout sslvpn on forticlient

    #password is saved, can connect without type in password
    open forticlient and select profile    ${profile}
    connect sslvpn on forticlient
    logout sslvpn on forticlient
    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    run keyword and ignore error    open forticlient and select profile    ${profile}
    run keyword and ignore error    uncheck client option    ${option}
    run keyword and ignore error    connect sslvpn on forticlient
    run keyword and ignore error    logout sslvpn on forticlient
    open forticlient and select profile    ${profile}
    run keyword and ignore error    reset forticlient profile
    write test result to file    ${CURDIR}
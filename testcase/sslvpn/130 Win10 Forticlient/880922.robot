*** Settings ***
Documentation    verify sslvpn forticlient full tunnel works normally
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${cmd1}     ping 172.16.200.55
${cmd2}     ping 8.8.8.8

*** Test Cases ***
880922
    [Tags]    win10   v6.0    v6.2    880922    screen_alive    forticlient_6.0.3.0155
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient

    OperatingSystem.run    route print >log/sslvpn_route
    ${new_route}=    OperatingSystem.grep file    log/sslvpn_route    10.212.134.200
    should match regexp    ${new_route}    0.0.0.0

    ${result1}=    OperatingSystem.run    ${cmd1}
    should match regexp    ${result1}    Reply from 172.16.200.55
    ${result2}=    OperatingSystem.run    ${cmd2}
    should match regexp    ${result2}    Reply from 8.8.8.8

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
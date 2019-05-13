*** Settings ***
Documentation    Suite description
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${cmd}     ping 172.16.200.55

*** Test Cases ***
716520
    [Tags]    win10   v6.0    v6.2    716520    screen_alive    forticlient_6.0.3.0155
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    #check local pc route table
    OperatingSystem.run    route print >log/sslvpn_route
    ${new_route}=    OperatingSystem.grep file    log/sslvpn_route    10.212.134.200
    should match regexp    ${new_route}    172.16.200.0
     # ping pc5
    ${result}=    OperatingSystem.run    ${cmd}
    should match regexp    ${result}    Reply from 172.16.200.55

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
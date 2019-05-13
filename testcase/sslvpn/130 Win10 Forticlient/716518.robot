*** Settings ***
Documentation    Suite description
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot


*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user

*** Test Cases ***
716518
    [Tags]    win10    v6.0    v6.2    716518    screen_alive    forticlient_6.0.3.0155
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    write test result to file    ${CURDIR}
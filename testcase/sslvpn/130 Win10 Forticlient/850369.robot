*** Settings ***
Documentation    Forticlient 5.4.4 SSLVPN connection default use TLS (423067)
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${url}     http://${SSLVPN_HTTP_IP}
${keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
@{diag_vpn_ssl_list}    diagnose vpn ssl list

*** Test Cases ***
850369
    [Tags]    win10    v6.0    v6.2    850369    screen_alive    forticlient_6.0.3.0155
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    check http on local pc    ${url}    ${keyword}
    @{responses}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${diag_vpn_ssl_list}
    ${response}=    set variable    @{responses}[-1]
    should not match regexp    ${response}    dtls

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    write test result to file    ${CURDIR}
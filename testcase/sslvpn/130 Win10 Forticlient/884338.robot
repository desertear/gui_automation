*** Settings ***
Documentation    Verify http service ok
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${url}     http://${SSLVPN_HTTP_IP}
${keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
@{diag_debug_disable}    diagnose debug disable

*** Test Cases ***
884338
    [Tags]    win10    v6.0    v6.2    884338    screen_alive    forticlient_6.0.3.0155
    #Config SSLVPN ON FGT
    [setup]    set forticlient dtls
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    check http on local pc    ${url}    ${keyword}
    @{responses}=    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}diagnose_sslvpn_list_cli.txt
    ${response}=    set variable    @{responses}[-1]
    should match regexp    ${response}    dtls
    logout sslvpn on forticlient

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    Execute CLI commands on FortiGate Via Direct Telnet    commands=${diag_debug_disable}
    set forticlient dtls
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    write test result to file    ${CURDIR}
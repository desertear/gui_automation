*** Settings ***
Documentation    Verify host check option av works, client pc will get pass if any av installed
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${url}     http://${SSLVPN_HTTP_IP}
${keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${hostcheck-error}    forticlient_host_check_deny.png

*** Test Cases ***
874817
    [Tags]    win10    v6.0    v6.2    874817    screen_alive    forticlient_6.0.3.0155
    # enable os check, win10 allow
    [setup]   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    #connect forticlient good
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    logout sslvpn on forticlient

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
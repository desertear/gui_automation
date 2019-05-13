*** Settings ***
Documentation    Verify replacement message for SSL vpn host security check can be modified and takes effect.
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${url}     http://${SSLVPN_HTTP_IP}
${keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${hostcheck-error}    forticlient_host_check_replaced_error.png

*** Test Cases ***
752112
    [Tags]    win10    v6.0    v6.2    752112    screen_alive    forticlient_6.0.3.0155
    # enable os check, win10 allow
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}os_check_win10_allow_cli.txt
    #connect forticlient good
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    logout sslvpn on forticlient

    # enable os check, win10 deny
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}os_check_win10_deny_cli.txt
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connection deny by host check    ${hostcheck-error}
    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}os_check_disable_cli.txt
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    run keyword and ignore error    close forticlient
    write test result to file    ${CURDIR}
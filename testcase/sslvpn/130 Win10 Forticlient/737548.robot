*** Settings ***
Documentation    Verify fortinet bar can be shown in ssl vpn tunnel mode.
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${IMAGE_DIR}      ${SIKULI_IMAGE_DIR}${/}forticlient
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_user
${url}     http://${SSLVPN_HTTP_IP}
${keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}

*** Test Cases ***
737548
    [Tags]    win10    v6.0    v6.2    737548    screen_alive    forticlient_6.0.3.0155
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}fortinet_bar_setup_cli.txt
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    check fortinet bar on local pc    ${url}    ${keyword}    ${IMAGE_DIR}

    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
     run keyword and ignore error    logout sslvpn on forticlient
    run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}fortinet_bar_teardown_cli.txt
    write test result to file    ${CURDIR}
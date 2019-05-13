*** Settings ***
Documentation    Verify windows Forticlient can custom login ssl vpn tunnel mode.
Library    SikuliLibrary    mode=NEW
Resource    ../sslvpn_resource.robot

*** Variables ***
${realm_name}   test
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${profile}    sslvpn_automation_realm

*** Test Cases ***
746196
    [Tags]    win10    v6.0    v6.2    746196    screen_alive    forticlient_6.0.3.0155
    Set Library Search Order    SeleniumLibrary    SikuliLibrary
    Login FortiGate
    Create ssl vpn realms    ${realm_name}
    Logout FortiGate
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_realm_setup_cli.txt
    #Config SSLVPN ON FGT
    open forticlient and select profile    ${profile}
    fill in username and password    ${username}    ${password}
    connect sslvpn on forticlient
    [Teardown]    case Teardown

*** Keywords ***

case Teardown
    [Arguments]
    run keyword and ignore error    logout sslvpn on forticlient
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_realm_teardown_cli.txt
    write test result to file    ${CURDIR}
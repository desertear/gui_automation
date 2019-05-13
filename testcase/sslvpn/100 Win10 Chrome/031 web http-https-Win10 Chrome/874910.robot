*** Settings ***
Documentation    sslvpn web mode HTTP application will generate event logs.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot

*** Test Cases ***
874910
    [Tags]    v6.0    firefox    chrome    edge    safari    874910    Medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt

    #clean previous logs
    Login SSLVPN Portal
    quick connection of http or https    ${SSLVPN_HTTP_IP}    ${SSLVPN_HTTP_PAGE_KEYWORD}
    sleep    10s
    Logout SSLVPN Portal
    sleep    30s
    # check http activated log

    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_traffic_check_cli.txt
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    service="HTTP"

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
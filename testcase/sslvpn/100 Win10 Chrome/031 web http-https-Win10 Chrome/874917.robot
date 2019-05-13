*** Settings ***
Documentation    sslvpn web mode HTTPS application will generate event logs.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${https_url}    https://${SSLVPN_HTTP_IP}

*** Test Cases ***
874917
    [Tags]    v6.0    firefox    chrome    edge    safari    874917    Medium    win10,64bit
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    #clean previous logs
    Login SSLVPN Portal
    quick connection of http or https    ${https_url}    ${SSLVPN_HTTPS_PAGE_KEYWORD}
    sleep    10s
    Logout SSLVPN Portal
    sleep    30s
    # check http activated log

    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_traffic_check_cli.txt
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    service="HTTPS"

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
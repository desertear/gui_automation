*** Settings ***
Documentation    sslvpn web mode HTTPS application will generate event logs.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${https_url}    https://${SSLVPN_HTTP_IP}
${msg1}    SSL web application activated
${msg2}    SSL web application closed
&{cli_dic1}    message=${msg1}
&{cli_dic2}    message=${msg2}

*** Test Cases ***
874916
    [Tags]    v6.0    firefox    chrome    edge    safari    874916    Medium    win10,64bit
    #clean previous logs
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    Login SSLVPN Portal
    quick connection of http or https    ${https_url}    ${SSLVPN_HTTPS_PAGE_KEYWORD}
    sleep    10s
    Logout SSLVPN Portal
    sleep    30s
    # check http activated log

    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic1}
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    reason="https"

    # check http closed log
    @{responses2}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic2}
    ${response2}=    set variable    @{responses2}[-1]
    should match regexp    ${response2}    reason="https"

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
*** Settings ***
Documentation    sslvpn web mode HTTP application will generate event logs.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
${ftp_matched_file_name}    ${SSLVPN_FTP_TEST_DIR}

${msg1}    SSL web application activated
${msg2}    SSL web application closed
&{cli_dic1}    message=${msg1}
&{cli_dic2}    message=${msg2}

*** Test Cases ***
877208
    [Tags]    v6.0    firefox    chrome    edge    safari    877208    High    win10,64bit
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    #clean previous logs
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    if ftp directory exists    ${ftp_matched_file_name}
    close window
    select window    MAIN
    Logout SSLVPN Portal
    sleep    30s
    # check application activated log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic1}
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    reason="ftp"
    # check application closed log
    @{responses2}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic2}
    ${response2}=    set variable    @{responses2}[-1]
    should match regexp    ${response2}    reason="ftp"

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
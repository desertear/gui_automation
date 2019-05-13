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

*** Test Cases ***
877209
    [Tags]    v6.0    firefox    chrome    edge    safari    877209    Medium    win10,64bit

    #clean previous logs
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    #sftp application
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    if ftp directory exists    ${ftp_matched_file_name}
    close window
    select window    MAIN
    Logout SSLVPN Portal
    sleep    30s
    # check traffic log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_traffic_check_cli.txt
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    service="FTP"

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
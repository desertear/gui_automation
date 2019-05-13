*** Settings ***
Documentation    sslvpn web mode HTTP application will generate event logs.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${sftp_host}    ${SSLVPN_SFTP_HOST}
${sftp_username}    ${SSLVPN_SFTP_USERNAME}
${sftp_password}    ${SSLVPN_SFTP_PASSWORD}
${sftp_matched_file_name}    ${SSLVPN_SFTP_TEST_DIR}

${msg1}    SSL web application activated
${msg2}    SSL web application closed
&{cli_dic1}    message=${msg1}
&{cli_dic2}    message=${msg2}

*** Test Cases ***
874743
    [Tags]    v6.0    firefox    chrome    edge    safari    874743    Medium    win10,64bit
    #clean previous logs
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    # Login sslvpn web mode and conect to sftp
    Login SSLVPN Portal
    connect to sftp    ${sftp_host}    username=${sftp_username}    password=${sftp_password}
    if ftp directory exists    ${sftp_matched_file_name}
    close window
    select window    MAIN
    Logout SSLVPN Portal
    sleep    30s
    # check application activated log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic1}
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    reason="sftp"
    # check application closed log
    @{responses2}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic2}
    ${response2}=    set variable    @{responses2}[-1]
    should match regexp    ${response2}    reason="sftp"

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
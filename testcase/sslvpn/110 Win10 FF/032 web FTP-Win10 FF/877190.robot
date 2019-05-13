*** Settings ***
Documentation    Verify sslvpn web portal ftp bookmark works and connect to correct directory
...   Action:
...    1. login web portal, connect to ftp sever.
...   Expect:
...    connected to FTP server and the directory is correct
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
${ftp_matched_file_name}    ${SSLVPN_FTP_TEST_DIR}
*** Test Cases ***
877190
    [Tags]    v6.0    firefox    chrome    edge    safari    877190    low    win10,64bit
    Login SSLVPN Portal
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    if ftp directory exists    ${ftp_matched_file_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
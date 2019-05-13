*** Settings ***
Documentation    Verify sslvpn web portal SFTP bookmark works and connect to correct directory (0491473)
...   Action:
...    1. login web portal, connect to ftp sever.
...   Expect:
...    connected to SFTP server and the directory is correct
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${sftp_host}    ${SSLVPN_SFTP_HOST}
${sftp_username}    ${SSLVPN_SFTP_USERNAME}
${sftp_password}    ${SSLVPN_SFTP_PASSWORD}
${sftp_matched_file_name}    ${SSLVPN_SFTP_TEST_DIR}
*** Test Cases ***
878033
    [Tags]    v6.0    firefox    chrome    edge    safari    878033    low    win10,64bit
    Login SSLVPN Portal
    connect to sftp    ${sftp_host}    username=${sftp_username}    password=${sftp_password}
    if ftp directory exists    ${sftp_matched_file_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
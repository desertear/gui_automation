*** Settings ***
Documentation    Verify quick connect FTP tools works properly
...    Action:
...    1. Log into SSL VPN portal
...    2. choose FTP tool, input target server ip. Click \'go\'
...    Expect:
...    ftp service running
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${ftp_host}    ${SSLVPN_FTP_HOST}
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
${ftp_existed_file_name}    ${SSLVPN_FTP_TEST_FILE}


*** Test Cases ***
877210
    [Tags]    v6.0    chrome    firefox    edge    safari    877210    Critical    win10,64bit
    Login SSLVPN Portal
    quick connection of ftp   ${ftp_host}    ${ftp_existed_file_name}    username=${ftp_username}    password=${ftp_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
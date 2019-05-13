*** Settings ***
Documentation    Verify dynamic URL in SSL VPN (smb/ftp) bookmark work (0411012)
...   Action:
...    1. login web portal, connect to samba sever.
...    2. choose a file and click on download
...   Expect:
...   the file has been downloaded successfully
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    ${SSLVPN_BROWSER}
${smb_host}    ${SSLVPN_SMB_HOST}/%username%
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${ftp_host}    ${SSLVPN_FTP_HOST}/%username%
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
*** Test Cases ***
877279
    [Tags]    v6.0    chrome    firefox    edge    safari    877279    high    win10,64bit
    Login SSLVPN Portal    browser=${browser}
    connect to smb    ${smb_host}    username=${smb_username}    password=${smb_password}
    ${cur_dir_name}=    get current smb dir name
    should be equal    ${cur_dir_name}    ${smb_username}
    close window
    select window    MAIN
    connect to ftp    ${ftp_host}    username=${ftp_username}    password=${ftp_password}
    ${cur_dir_name}=    get current ftp dir name
    should be equal    ${cur_dir_name}    ${ftp_username}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}


*** Keywords ***
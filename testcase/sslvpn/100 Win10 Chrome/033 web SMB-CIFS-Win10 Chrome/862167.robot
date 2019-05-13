*** Settings ***
Documentation    Verify that sslvpn web mode SMBv2 connection works
...   Action:
...    1. set up smb server with smbv1 and config sslvpn and firewall policy
...    2. connect to sslvpn web mode and create smb bookmark, click SMB bookmark
...   Expect:
...   connect to SMB server
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    ${SSLVPN_BROWSER}
${smb_upper_most_dir_name}    ${SSLVPN_SMB_MOST_UPPER_DIR}
${smb_host_v2}    ${SSLVPN_SMB_HOST}
${smb_username_v2}    ${SSLVPN_SMB_USERNAME}
${smb_password_v2}    ${SSLVPN_SMB_PASSWORD}
*** Test Cases ***
862167
    [Tags]    v6.0    chrome    firefox    edge    safari    862167    high    win10,64bit
    Login SSLVPN Portal    browser=${browser}
    connect to smb    ${smb_host_v2}    username=${smb_username_v2}    password=${smb_password_v2}
    ${cur_dir_name}=    get current smb dir name
    should be equal    ${cur_dir_name}    ${smb_host_v2}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}


*** Keywords ***
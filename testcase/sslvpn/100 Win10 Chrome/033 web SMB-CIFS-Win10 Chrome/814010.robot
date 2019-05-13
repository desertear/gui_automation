*** Settings ***
Documentation    Verify that sslvpn web mode is able to connect to smb server which support only ntlmv2 (mantis 371933)
...   Action:
...    Tested on Windows server 2012.
...    Command:> secpol.msc
...    Configure Security Settings\Local Policies\Security Options\Network security: LAN Manager authentication level as "Send NTLMv2 response only\refuse LM & NTLM".
...    2. Configure sslvpn web mode portal with smb bookmark.
...   Expect:
...   should be connected.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${dir_name}    test_directory
${smb_host_win2012}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
*** Test Cases ***
814010
    [Tags]    v6.0    firefox    chrome    edge    safari    814010    medium    win10,64bit
    Login SSLVPN Portal
    connect to smb    ${smb_host_win2012}    username=${smb_username}    password=${smb_password}
    go to smb upper most directory    ${SSLVPN_SMB_MOST_UPPER_DIR}
    go to smb directory    ${SSLVPN_SMB_TEST_DIR}
    create new smb directory    ${dir_name}
    delete smb directory    ${dir_name}
    close window
    select window    MAIN
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
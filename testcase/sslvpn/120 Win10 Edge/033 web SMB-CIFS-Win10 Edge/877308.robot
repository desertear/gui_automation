*** Settings ***
Documentation    Verify sslvpn web mode SMB application Startup will generate event logs
...    Action:
...    1. Log into SSL VPN portal
...    2. choose Samba/CIFS tool, input target server ip. Click \'go\'
...    3. logout sslvpn web mode and wait for 30s
...    4. cli check event log

Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${smb_dir}    ${SSLVPN_SMB_MOST_UPPER_DIR}

${msg1}    SSL web application activated
${msg2}    SSL web application closed
&{cli_dic1}    message=${msg1}
&{cli_dic2}    message=${msg2}

*** Test Cases ***
877308
    [Tags]    v6.0    chrome    firefox    edge    safari    877308    Medium    win10,64bit    bug
    # delete all logs
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    # login in sslvpn web portal and quick connect to smb
    Login SSLVPN Portal
    quick connection of smb or cifs    ${smb_host}    ${smb_dir}    username=${smb_username}    password=${smb_password}
    # disconect and wait to 30s
    Logout SSLVPN Portal
    sleep    30s
    # check application activated log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_event_check_cli.txt    &{cli_dic1}
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    reason="smb"

    # check application closed log
    @{responses2}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_cli.txt    &{cli_dic2}
    ${response2}=    set variable    @{responses2}[-1]
    should match regexp    ${response2}    reason="smb"

    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
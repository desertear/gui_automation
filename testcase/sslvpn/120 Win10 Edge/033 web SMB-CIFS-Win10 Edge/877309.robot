*** Settings ***
Documentation    Verify sslvpn web mode SMB application will generate traffic logs
...    Action:
...    1. Log into SSL VPN portal
...    2. choose Samba/CIFS tool, input target server ip. Click \'go\'
...    3. logout sslvpn web mode and wait for 30s
...    4. cli check traffic log

Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${smb_dir}    ${SSLVPN_SMB_MOST_UPPER_DIR}

*** Test Cases ***
877309
    [Tags]    v6.0    chrome    firefox    edge    safari    877309    Medium    win10,64bit    special_env
    # delete all logs
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_delete_cli.txt
    # login in sslvpn web portal and quick connect to smb
    Login SSLVPN Portal
    quick connection of smb or cifs    ${smb_host}    ${smb_dir}    username=${smb_username}    password=${smb_password}
    # disconect and wait to 30s
    Logout SSLVPN Portal
    sleep    30s
    # check traffic log
    @{responses1}=   Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}sslvpn_log_traffic_check_cli.txt
    ${response1}=    set variable    @{responses1}[-1]
    should match regexp    ${response1}    service="SAMBA"

    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
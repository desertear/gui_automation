*** Settings ***
Documentation    Verify quick connection Samba/CIFS tool works properly
...    Action:
...    1. Log into SSL VPN portal
...    2. choose Samba/CIFS tool, input target server ip. Click \'go\'
...    Expect:
...    Ok to access samba service
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${smb_host}    ${SSLVPN_SMB_HOST}
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${smb_dir}    ${SSLVPN_SMB_MOST_UPPER_DIR}

*** Test Cases ***
877265
    [Tags]    v6.0    chrome    firefox    edge    safari    877265    high    win10,64bit    special_env
    Login SSLVPN Portal
    quick connection of smb or cifs    ${smb_host}    ${smb_dir}    username=${smb_username}    password=${smb_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
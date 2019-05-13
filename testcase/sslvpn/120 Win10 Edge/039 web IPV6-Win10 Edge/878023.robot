*** Settings ***
Documentation    samba service works normally in sslvpn web mode IPv6
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_ipv6}    ${SSLVPN_URL_V6}
${smb_host}    [${SSLVPN_SMB_HOST_V6}]
${smb_username}    ${SSLVPN_SMB_USERNAME}
${smb_password}    ${SSLVPN_SMB_PASSWORD}
${smb_dir}    ${SSLVPN_SMB_MOST_UPPER_DIR}
*** Test Cases ***
878023
    [Tags]    v6.0    chrome    firefox    edge    safari    878023    high    win10,64bit    bug
    Login SSLVPN Portal    url=${url_ipv6}
    quick connection of smb or cifs    ${smb_host}    ${smb_dir}    username=${smb_username}    password=${smb_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
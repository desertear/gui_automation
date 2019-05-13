*** Settings ***
Documentation    ftp service works normally in sslvpn web mode IPv6
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_ipv6}    ${SSLVPN_URL_V6}
${ftp_host}    [${SSLVPN_FTP_HOST_V6}]
${ftp_username}    ${SSLVPN_FTP_USERNAME}
${ftp_password}    ${SSLVPN_FTP_PASSWORD}
${ftp_existed_file_name}    ${SSLVPN_FTP_TEST_FILE}

*** Test Cases ***
878022
    [Tags]    v6.0    chrome    firefox    edge    safari    878022    medium    win10,64bit    bug
    Login SSLVPN Portal    url=${url_ipv6}
    quick connection of ftp   ${ftp_host}    ${ftp_existed_file_name}    username=${ftp_username}    password=${ftp_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
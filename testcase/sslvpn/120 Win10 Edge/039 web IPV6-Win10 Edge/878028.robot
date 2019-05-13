*** Settings ***
Documentation    sftp service works normally in sslvpn ipv6 web mode.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_ipv6}    ${SSLVPN_URL_V6}
${sftp_host}    [${SSLVPN_SFTP_HOST_V6}]
${sftp_username}    ${SSLVPN_SFTP_USERNAME}
${sftp_password}    ${SSLVPN_SFTP_PASSWORD}
${sftp_existed_file_name}    ${SSLVPN_SFTP_TEST_FILE}

*** Test Cases ***
878028
    [Tags]    v6.0    chrome    firefox    edge    safari    878028    medium    win10,64bit    bug
    Login SSLVPN Portal    url=${url_ipv6}
    quick connection of sftp   ${sftp_host}    ${sftp_existed_file_name}    username=${sftp_username}    password=${sftp_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
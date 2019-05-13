*** Settings ***
Documentation    SSH service works normally in sslvpn ipv6 web mode.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_ipv6}    ${SSLVPN_URL_V6}
${ssh_host}    [${SSLVPN_SSH_HOST_V6}]
${ssh_username}    ${SSLVPN_SSH_USERNAME}
${ssh_password}    ${SSLVPN_SSH_PASSWORD}

*** Test Cases ***
878025
    [Tags]    v6.0    chrome    firefox    edge    safari    878025    high    win10,64bit    bug
    Login SSLVPN Portal    url=${url_ipv6}
    quick connection of ssh    ${ssh_host}    ${ssh_username}    ${ssh_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
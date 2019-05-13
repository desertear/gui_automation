*** Settings ***
Documentation    Telnet service works normally in sslvpn ipv6 web mode.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_ipv6}    ${SSLVPN_URL_V6}
${telnet_host}    [${SSLVPN_TELNET_HOST_V6}]
${telnet_username}    ${SSLVPN_TELNET_USERNAME}
${telnet_password}    ${SSLVPN_TELNET_PASSWORD}

*** Test Cases ***
731861
    [Tags]    v6.0    chrome    firefox    edge    safari    731861    high    win10,64bit
    Login SSLVPN Portal    url=${url_ipv6}
    quick connection of telnet    ${telnet_host}    ${telnet_username}    ${telnet_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
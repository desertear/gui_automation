*** Settings ***
Documentation    Ping service works normally in sslvpn ipv6 web mode.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${url_ipv6}    ${SSLVPN_URL_V6}
${ping_host}    [${SSLVPN_PING_HOST_V6}]

*** Test Cases ***
878016
    [Tags]    v6.0    chrome    firefox    edge    safari    878016    high    win10,64bit
    Login SSLVPN Portal    url=${url_ipv6}
    quick connection of ping    ${ping_host}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
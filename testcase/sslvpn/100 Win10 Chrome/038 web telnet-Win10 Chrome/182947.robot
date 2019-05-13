*** Settings ***
Documentation    Verify quick connection Telnet tool works properly
...    Action:
...    1. Log into SSL VPN portal
...    2.  choose telnet tool, input target telnet server ip. Click \'go\'
...    Expect:
...    A GUI ssh window appeared with connect enabled.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${telnet_host}    ${SSLVPN_TELNET_HOST}
${telnet_username}    ${SSLVPN_TELNET_USERNAME}
${telnet_password}    ${SSLVPN_TELNET_PASSWORD}

*** Test Cases ***
182947
    [Tags]    v6.0    chrome    firefox    edge    safari    182947    critical    win10,64bit
    Login SSLVPN Portal
    quick connection of telnet    ${telnet_host}    ${telnet_username}    ${telnet_password}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
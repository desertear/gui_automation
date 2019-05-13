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
${bookmark_name}    bookmark_telnet
${telnet_host}    ${SSLVPN_TELNET_HOST}
${telnet_username}    ${SSLVPN_TELNET_USERNAME}
${telnet_password}    ${SSLVPN_TELNET_PASSWORD}

*** Test Cases ***
715965
    [Tags]    v6.0    chrome    firefox    edge    safari    715965    medium    win10,64bit
    Login SSLVPN Portal
    open and cli check telnet bookmark    ${bookmark_name}    ${telnet_host}    ${telnet_username}    ${telnet_password}   if_predefined=${True}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
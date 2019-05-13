*** Settings ***
Documentation    Verify quick connection SSH tool works properly (5.4 and below need java support, only work with IE).
...    Action:
...    1. Log into SSL VPN portal
...    2. choose ssh tool, input target telnet server ip. Click \'go\'
...    Expect:
...    A GUI ssh window appeared with connect enabled.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${host1}    127.0.0.1
${host2}    [::1]
${url_ipv6}    ${SSLVPN_URL_V6}
${local_user}    ${SSLVPN_GUI_USERNAME}
${local_password}    ${SSLVPN_GUI_PASSWORD}
*** Test Cases ***
881777
    [Tags]    v6.0    chrome    firefox    edge    safari    881777    high    win10,64bit
    Login SSLVPN Portal
    Fail connection of ssh    ${host1}
    Fail connection of telnet    ${host1}
    Logout SSLVPN Portal
    close browser
    #check ipv6
    Login SSLVPN Portal    url=${url_ipv6}    username=${local_user}    password=${local_password}
    Fail connection of ssh    ${host2}
    Fail connection of telnet    ${host2}
    Logout SSLVPN Portal
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
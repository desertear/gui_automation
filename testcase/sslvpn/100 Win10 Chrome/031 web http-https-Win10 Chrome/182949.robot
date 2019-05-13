*** Settings ***
Documentation    Verify quick connection Ping tool Test for Reachability works properly
...    Action:
...    1. Log into SSL VPN portal
...    2. choose ping tool, input target server ip. Click \'go\'
...    Expect:
...    A box prompts server is reachable
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${browser}    firefox
${ping_host1}    ${SSLVPN_PING_HOST}
${ping_host2}    www.google.ca

*** Test Cases ***
182949
    [Tags]    v6.0    firefox    182949    high    win10,64bit
    Login SSLVPN Portal    browser=${browser}
    quick connection of ping    ${ping_host1}
    quick connection of ping    ${ping_host2}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
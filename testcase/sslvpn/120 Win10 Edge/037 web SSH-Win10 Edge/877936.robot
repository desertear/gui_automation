*** Settings ***
Documentation    Verify quick connection SSH tool works properly
...    Action:
...    1. Log into SSL VPN portal
...    2. choose ssh tool, input target telnet server ip. Click \'go\'
...    Expect:
...    A GUI ssh window appeared with connect enabled.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${bookmark_name}    bookmark_ssh
${ssh_host}    ${SSLVPN_SSH_HOST}
${ssh_username}    ${SSLVPN_SSH_USERNAME}
${ssh_password}    ${SSLVPN_SSH_PASSWORD}

*** Test Cases ***
877936
    [Tags]    v6.0    chrome    firefox    edge    safari    877936    medium    win10,64bit
    Login SSLVPN Portal
    open and cli check ssh bookmark    ${bookmark_name}    ${ssh_host}    ${ssh_username}    ${ssh_password}        if_predefined=${True}
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
*** Settings ***
Documentation     This file contains FortiGate GUI Monitor operation

*** Keywords ***
###Monitor->SSL-VPN monitor##
##SSL-VPN monitor##
Go to SSL VPN monitor
    Wait Until Element Is Visible    ${MONITOR_SSL_VPN_ENTRY}
    click element    ${MONITOR_SSL_VPN_ENTRY}

Check SSL VPN monitor
    [Arguments]    ${username}    ${connection_type}    ${host}
    ${row_locator}=    set variable    xpath://span[text()="${connection_type}: ${host}"]
    Go to Monitor
    Go to SSL VPN monitor
    wait Until element is Visible    ${MONITOR_SSL_VPN_REFRESH_BUTTON}
    Wait Until Keyword Succeeds    5x    10s    refresh ssl vpn page and check monitor    ${row_locator}

refresh ssl vpn page and check monitor
    [Arguments]    ${row_locator}
    click button    ${MONITOR_SSL_VPN_REFRESH_BUTTON}
    Wait Until Page Contains Element    ${row_locator}

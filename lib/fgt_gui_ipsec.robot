*** Settings ***
Documentation     This file contains FortiGate GUI IPSEC VPN operation

*** Keywords ***
##IPsec Tunnels##
Go to IPsec Tunnels
    Wait Until element is visible    ${IPSEC_TUNNELS_ENTRY}
    click element    ${IPSEC_TUNNELS_ENTRY}


Open Section Label on IPsec Tunnels
    [Arguments]   ${tunnel_type}
    [Documentation]    ${tunnel_type} can be "Custom"
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_IPSEC_TUNNELS_TOGGLE_BUTTON}    ${tunnel_type}
    Click Toggle if Closed    ${toggle_locator}

Close Section Label on IPsec Tunnels
    [Arguments]   ${tunnel_type}
    [Documentation]    ${tunnel_type} can be "General", "Web Access", "File Access", etc
    ${toggle_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_IPSEC_TUNNELS_TOGGLE_BUTTON}    ${tunnel_type}
    Click Toggle if Opened    ${toggle_locator}  
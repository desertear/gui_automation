*** Settings ***
Documentation     This file contains FortiGate Traffic Shaper, Shaping Policy and Shaping Profile function

*** Keywords ***
##Policy & Objects ->Multicast policy##

# Click FOS GUI menu and navigate to Multicast Policy list page
Go to Multicast policy
    Wait Until Element Is Visible    ${MENU_POLICY_MULTICAST_POLICY}
    Click Element    ${MENU_POLICY_MULTICAST_POLICY}  
    Wait Until Element Is Visible    ${POLICY_MULTICAST_TABLE_NAME}
    Wait Until Element Is Visible    ${POLICY_MULTICAST_TABLE_PROTOCOL}
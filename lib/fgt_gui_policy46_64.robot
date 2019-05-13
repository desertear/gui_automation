*** Settings ***
Documentation     This file contains FortiGate Traffic Shaper, Shaping Policy and Shaping Profile function

*** Keywords ***
##Policy & Objects ->NAT64 Policy##

# Click FOS GUI menu and navigate to Shaping Policy list page
Go to NAT64 policy
    Wait Until Element Is Visible    ${MENU_POLICY_NAT64_POLICY}
    click element    ${MENU_POLICY_NAT64_POLICY}
    Wait Until Element Is Visible    ${POLICY_NAT_TABLE_SOURCE_ADDRESS}

##Policy & Objects ->NAT46 Policy##  
Go to NAT46 policy
    Wait Until Element Is Visible    ${MENU_POLICY_NAT46_POLICY}
    click element    ${MENU_POLICY_NAT46_POLICY}
    Wait Until Element Is Visible    ${POLICY_NAT_TABLE_SOURCE_ADDRESS}  

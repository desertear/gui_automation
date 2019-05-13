*** Settings ***
Documentation     This file contains FortiGate GUI Network

*** Keywords ***
###Network###
##Network -> Interfaces##
Go to Interfaces
    Wait Until Element Is Visible    ${NETWORK_INTERFACES_ENTRY}    10
    click element    ${NETWORK_INTERFACES_ENTRY}

##Network -> Static Routes##
Go to Static Routes
    Wait Until Element Is Visible    ${NETWORK_STATIC_ROUTES_ENTRY}    10
    click element    ${NETWORK_STATIC_ROUTES_ENTRY}


View Interfaces Alphabetically
    Wait Until Element Is Visible    ${NETWORK_INTERFACES_VIEW_ALPHABETICALLY_BUTTON}
    Click Button    ${NETWORK_INTERFACES_VIEW_ALPHABETICALLY_BUTTON}
    Wait Until Element Is Visible    ${NETWORK_INTERFACES_VIEW_ALPHABETICALLY_BUTTON_SELECTED}

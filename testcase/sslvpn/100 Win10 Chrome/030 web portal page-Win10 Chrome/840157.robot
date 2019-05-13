*** Settings ***
Documentation    Verify GUI could config customized forticlient download and work (0437883)
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${win_url}    www.google.ca
${mac_url}    www.bing.com
${portal_name}    ${FGT_SSLVPN_PORTAL_NAME}
*** Test Cases ***
840157
    [Tags]    v6.0    chrome    firefox    edge    840157    high    win10,64bit
    #configure location on FGT
    Set Customize Download Location on FGT    ${True}    ${True}    ${True}    ${win_url}    ${mac_url}
    ##open SSLVPN portal and check the download link
    Login SSLVPN Portal
    #click "Download fortiClient" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_BUTTON}
    #record opened windows
    ${exclude}=    Get window handles
    #click "Windows" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_WINDOWS_BUTTON}
    #a new window is opened
    ${older_window}=    Select window    ${exclude}
    #check if url of the new window contains "forticlient.com", which means it opens Forticlient home page.
    ${url}=    Get Location
    should contain    ${url}    ${win_url}
    #close newer window
    close window
    switch back to ssl vpn portal    ${older_window}
    #click "Download fortiClient" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_BUTTON}
    #record opened windows
    ${exclude}=    Get window handles
    #click "Windows" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_MAC_BUTTON}
    #a new window is opened
    ${older_window}=    Select window    ${exclude}
    #check if url of the new window contains "forticlient.com", which means it opens Forticlient home page.
    ${url}=    Get Location
    should contain    ${url}    ${mac_url}
    #close newer window
    close window
    switch back to ssl vpn portal    ${older_window}
    #close SSLVPN portal browser
    close browser
    ##set location to default on FGT
    Set Customize Download Location on FGT
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***
Set Customize Download Location on FGT
    [Arguments]    ${customized_status}=${False}    ${windows_status}=${False}    ${mac_status}=${False}    ${windows_url}=${EMPTY}    ${mac_url}=${EMPTY}
    Login FortiGate
    Go to VPN
    Go to SSL VPN Portals
    ${status}=    If ssl vpn portal exists    ${portal_name}
    should be true    ${status}
    click element    xpath://tbody/tr/td[text()="${portal_name}"]
    click button    ${VPN_EDIT_PORTAL_BUTTON}
    Wait Until Element Is Visible    ${VPN_PORTAL_EDIT_HEAD}
    Wait Until Element Is Visible    ${VPN_EDIT_CONFIRM_OK_BUTTON}
    Set Customize Download Location    ${customized_status}    ${windows_status}    ${mac_status}    ${windows_url}    ${mac_url}
    click button    ${VPN_PORTAL_OK_BUTTON}
    #check if the portal is updated successfully
    Wait Until Page Contains element    ${VPN_PORTAL_CREATE}
    ${created_portal}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_VPN_PORTAL_NAME_IN_TABLE}    ${portal_name}
    Wait Until Page Contains element    ${created_portal}
    Logout FortiGate
    [Teardown]    close browser

*** Settings ***
Documentation    Verify clicking forticlient-download widget link can re-directed to FortiClient App download page on the google play.
...    Create ssl vpn portal with "forticlient download" widget selected. Create ssl vpn related firewall policy with portal and user group associated.
...    Login ssl vpn web mode in android tablet.
...    Try to download forticlient by clicking the link "Forticlient windows" in "forticlient download" widget.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
743945
    [Tags]    v6.0    chrome    743945    medium    android
    Login SSLVPN Portal
    #click "Download fortiClient" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_BUTTON}
    #record opened windows
    ${exclude}=    Get window handles
    #click "Windows" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_ANDROID_BUTTON}
    #a new window is opened
    ${older_window}=    Select window    ${exclude}
    #check if url of the new window contains "forticlient.com", which means it opens Forticlient home page.
    ${url}=    Get Location
    should contain    ${url}    play.google.com
    #close newer window
    close window
    #switch back to sslvpn portal
    [Teardown]    case Teardown    ${older_window}

*** Keywords ***
case Teardown
    [Arguments]    ${older_window}
    run keyword and ignore error    switch back to ssl vpn portal    ${older_window}
    write test result to file    ${CURDIR}
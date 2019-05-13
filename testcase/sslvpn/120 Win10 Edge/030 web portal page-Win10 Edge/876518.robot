*** Settings ***
Documentation    Verify online help are related to the context
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
876518
    [Tags]    v6.0    firefox    chrome    edge    safari    876518    low    win10,64bit
    Login SSLVPN Portal
    #record opened windows
    ${exclude}=    Get window handles
    #click "question mark" button
    click button    ${PORTAL_HELP_BUTTON}
    #a new window is opened
    ${older_window}=    Select window    ${exclude}
    #check if url of the new window contains "forticlient.com", which means it opens Forticlient home page.
    ${url}=    Get Location
    should contain    ${url}    help.fortinet.com/fos60hlp
    #close newer window
    close window
    #switch back to sslvpn portal
    [Teardown]    case Teardown    ${older_window}

*** Keywords ***
case Teardown
    [Arguments]    ${older_window}
    run keyword and ignore error    switch back to ssl vpn portal    ${older_window}
    run keyword and ignore error    write test result to file    ${CURDIR}
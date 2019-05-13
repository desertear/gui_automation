*** Settings ***
Documentation    Verify MAC OS forticlient can be download in the forticlient-download widget.
...    Create ssl vpn portal with "forticlient download" widget selected. Create ssl vpn related firewall policy with portal and user group associated.
...    Login ssl vpn web mode in MAC OS Safari.
...    Try to download forticlient by clicking the link "Forticlient windows" in "forticlient download" widget.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${download_path}    ${SSLVPN_FILE_DOWNLOAD_DIR_PATH}
${file_name}    FortiClientMiniSetup-Mac-Enterprise-6.0.5.dmg
*** Test Cases ***
714658
    [Tags]    v6.0    chrome    firefox    714658    high    macos
    Login SSLVPN Portal
    #click "Download fortiClient" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_BUTTON}
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_MAC_BUTTON}
    Wait Until Keyword Succeeds    30    5s    file download should be done    ${download_path}${/}${file_name}
    Remove File    ${download_path}${/}${file_name}

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}

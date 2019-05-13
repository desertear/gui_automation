*** Settings ***
Documentation    Verify sslvpn web mode will not show predefined bookmarks when display-bookmark disable
...   Action:
...   1. establish vpn connection,portal appears.
...   2. prededined bookmarks show and work'
...   Expect:
...   The target website\'s page displayed.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${bookmark_group}    gui-bookmarks

*** Test Cases ***
833997
    [Tags]    v6.0    chrome    firefox    edge    safari    833997    high    win10,64bit

    Login SSLVPN Portal
    wait Until page contains element    ${PORTAL_QUICK_CONNECTION_BUTTON}
    Wait Until Page contains element    ${PORTAL_NEW_BOOKMARK_BUTTON}
    Current Frame Should Not Contain    ${bookmark_group}

    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
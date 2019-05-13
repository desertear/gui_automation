*** Settings ***
Documentation    verify sslvpn web portal can visit newer version FGT admin login page, vdom and tabs
...   Action:
...   1. (bug id: 82042 )login web portal, use the Connection tool or Bookmarks to access a web page which have javascripts.
...   Expect:
...   succeed to open javascript page.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
*** Test Cases ***
853610
    [Tags]    v6.0    chrome    firefox    edge    safari    853610    critical    win10,64bit    bug
    Login SSLVPN Portal
    quick connection of http or https    ${FGT_6.2}    Login
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***

*** Settings ***
Documentation    Verify user can relogin ssl vpn web mode if user close browser without logout normally.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***

*** Test Cases ***
876487
    [Tags]    v6.0    firefox    chrome    edge    safari    876487    medium    win10,64bit
    Login SSLVPN Portal
    close browser
    Login SSLVPN Portal
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
*** Settings ***
Documentation    Verify wanopt local host id in its global setting can be configured from GUI in the wanopt Peers page.
Resource    ../wanopt_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${wanopt_local_host}    FGT_Client
    
*** Test Cases ***
209998
    [Documentation]    
    [Tags]    6.2.0    wanopt    firefox    209998    high    win10    runable

    Login FortiGate    browser=firefox

    Edit Wanopt Local Host ID   ${wanopt_local_host}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}
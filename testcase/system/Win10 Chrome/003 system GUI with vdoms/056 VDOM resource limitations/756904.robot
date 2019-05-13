*** Settings ***
Documentation      Verify GUI can monitor vdom CPU/Memory/session usage
Resource    ../../../system_resource.robot

*** Variables ***

@{list_defult}    CPU   Memory   Sessions    
*** Test Cases ***
756904
##
    [Tags]    v6.0    chrome   756904    high    win10,64bit    browsers    runable
    
    Login FortiGate     
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}     
    go to dashboard
    go to dashboard_main
    sleep  2
    check if the widget is reset to default    @{list_defult}    
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

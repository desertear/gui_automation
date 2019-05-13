*** Settings ***
Documentation    GUI:Verify Object usage visibility function wokrs in NAT mode
##hasn't been finished
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
702357
    [Tags]    v6.0    chrome   702357    Medium    win10,64bit    browsers   norun 
    Login FortiGate    
    sleep  2s
   
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

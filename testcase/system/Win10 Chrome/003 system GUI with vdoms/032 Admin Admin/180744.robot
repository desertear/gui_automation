*** Settings ***
Documentation    Verify System logout selection works
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
180744
    [Documentation]    
    [Tags]    v6.0    chrome   180744    Critical    win10,64bit   runable
    Login FortiGate  
    ${stauts}=   run keyword and return status   Logout FortiGate  
    should be equal    "${stauts}"   "True"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Close All Browsers
    write test result to file    ${CURDIR}


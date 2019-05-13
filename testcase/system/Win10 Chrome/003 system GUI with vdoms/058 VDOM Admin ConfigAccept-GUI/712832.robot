*** Settings ***
Documentation      GUI:Verify Hide VDOM field when not in VDOM mode
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
712832
##
    [Tags]    v6.0    chrome   712832    high    win10,64bit    browsers    runable   test10
    Login FortiGate    
    sleep    2
    ${status}=   run keyword and return status    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_2}
    should be equal   "${status}"    "True"
    ${status}=   run keyword and return status    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}    ${SYSTEM_TEST_VDOM_NAME_2}
    should be equal   "${status}"    "True"
    ${status}=   run keyword and return status    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}    ${SYSTEM_TEST_VDOM_NAME_1}
    should be equal   "${status}"    "True"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}


*** Settings ***
Documentation      To verify interface are displayed per vdom.
Resource    ../../../system_resource.robot

*** Variables ***
@{vdom_list}     ${SYSTEM_TEST_VDOM_NAME_2}     ${SYSTEM_TEST_VDOM_NAME_TP}

*** Test Cases ***
181536
##
    [Tags]    v6.0    chrome   181536    high    win10,64bit    browsers    runable   rest
    Login FortiGate  
    sleep   2  
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    sleep   2
    Go to network
    Go to network_Interfaces
    ${num}=    COUNT INTERFACES OF VDOM      ${SYSTEM_TEST_VDOM_NAME_1} 
    should be equal   "${num}"    "4"
    Unselect Frame
    Go to Global
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}
    Go to network
    Go to network_Interfaces
    ${num}=    COUNT INTERFACES OF VDOM      ${SYSTEM_TEST_VDOM_NAME_TP}
    should be equal   "${num}"    "0"
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}


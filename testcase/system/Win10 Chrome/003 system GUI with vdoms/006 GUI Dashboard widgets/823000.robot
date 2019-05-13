*** Settings ***
Documentation    Verify Sessions widget can display SPU and nTurbo offloaded sessions
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
823000
##   Verify Sessions widget can display SPU and nTurbo offloaded sessions
    [Tags]    v6.0    chrome   823000    High    win10,64bit    browsers    runable   novm
    
    Login FortiGate     
    Go to system
    go to dashboard
    go to dashboard_main
    ${SPU_usage}=     get text   ${system_widget_SPU_Current usage_value}
    ${nTurbo_usage}=  get text   ${system_widget_nTurbo_Current usage_value}
    ${SPU_usage}=     Fetch From Left   ${SPU_usage}   %
    ${nTurbo_usage}=  Fetch From Left   ${nTurbo_usage}    %
    Should Be True    ${spu_usage}<10
    Should Be True    ${nTurbo_usage}<10
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

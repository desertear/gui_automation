*** Settings ***
Documentation    Verify Load .out Image can display correct Firmware version with Interim label from GUI and CLI
Resource    ../../../system_resource.robot

*** Variables ***
@{command}     get system status | grep Version:
*** Test Cases ***
828281
##   Verify Load .out Image can display correct Firmware version with Interim label from GUI and CLI
    [Tags]    v6.0    chrome   828281    Critical    win10,64bit    browsers    runable    
    Login FortiGate     
    @{response}=    Execute CLI commands on FortiGate Via Terminal Server     ${command}  
    ${resp}=        SET VARIABLE   @{response}[-1]
    ${release}=     FETCH FROM RIGHT   ${resp}      (
    ${release}=     FETCH FROM LEFT    ${release}   )
    ${release_GA}=   run keyword and return status   should contain   ${release}   GA
    Go to system
    go to dashboard
    go to dashboard_main
    run keyword if     "${release_GA}"=="False"    Test Interim    ${release}
    ...    ELSE    Test GA
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

Test Interim
    [Arguments]    ${release}
    Wait Until Element Is Visible    ${system_main_portalpage_release_info_type_span} 
    ${info}=   get text   ${system_main_portalpage_release_info_type_span} 
    Should Contain        ${info}    ${release}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${system_main_portalpage_release_info_build_span}    
    ${info}=      run keyword if    "${status}"=="True"    get text   ${system_main_portalpage_release_info_build_span}    
    run keyword if    "${status}"=="True"     Should Contain    ${info}    build${FGT_BUILD}

Test GA
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${system_main_portalpage_release_info_type_span} 
    should be equal    "${status}"   "False"
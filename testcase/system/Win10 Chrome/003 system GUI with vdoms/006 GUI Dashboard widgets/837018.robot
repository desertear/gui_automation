*** Settings ***
Documentation    Verify highlight license widget when device is not registered with FortiCare
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
837018
##   Verify highlight license widget when device is not registered with FortiCare, warning message in main page
    [Tags]    v6.0    chrome   837018    Critical    win10,64bit    browsers    runable
    
    Login FortiGate     
    Go to system
    Go to System_FortiGuard
    Wait Until Element Is Visible    ${System_Fortiguard_license info_status1_forticare} 
    ${registed_status}=   Get text   ${System_Fortiguard_license info_status1_forticare} 
    ${test}=     Run keyword and return status    Should contain   ${registed_status}   Not Registered
    ${warning_status}=    Run keyword if   "${test}"=="True"  get forticare warning status on main page      
    Run keyword if   "${test}"=="True"   Should contain   ${warning_status}    severity-critical
    sleep  2
    Go to dashboard
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

get forticare warning status on main page
    go to dashboard
    go to dashboard_main
    Wait Until Element Is Visible       ${License_widget_FortiCare Support_status icon} 
    ${warning}=  Get Element Attribute  ${License_widget_FortiCare Support_status icon}   class
    [Return]   ${warning} 

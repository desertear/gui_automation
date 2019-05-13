*** Settings ***
Documentation    Verify Dashboard extension:Multiple widgets function "add widget" works and it can auto-refresh once
Resource    ../../../system_resource.robot

*** Variables ***
@{list_defult}   System Information   License Status    Administrators  CPU   Memory   Sessions

*** Test Cases ***
596505
##
    [Tags]    v6.0    chrome   596505    critical    win10,64bit    browsers    runable
    
    Login FortiGate     
    Go to Global
    Go to system
    go to dashboard
    go to dashboard_main
    
    #### add interface ####
    ${interface}=   Set Variable  ${FGT_VLAN30_INTERFACE}
    system_Add_widget_bandwith    ${interface}
    ###check if interface widget appear in main page###
    ${exist}=    check if the Bandwidth of interface widget is appeared in the main page    ${interface}
    Should Be Equal  "${exist}"   "True"
    
        ${interface1}=    system_Add_widget_bandwith_firtst_interface_on_menu
        ###check if interface widget appear in main page###
        ${exist}=    check if the Bandwidth of interface widget is appeared in the main page    ${interface1}
           Should Be Equal   "${exist}"    "True"
    ###  reset to default ###
    system_click_widget_setting_button
    Wait and click    ${system_widget_setting_reset_dashboards_button}
    Wait and click    ${system_widget_setting_reset_dashboards_OK_button}
    check if the widget is reset to default    @{list_defult}    
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

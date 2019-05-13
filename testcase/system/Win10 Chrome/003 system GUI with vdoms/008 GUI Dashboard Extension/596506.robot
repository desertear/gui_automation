*** Settings ***
Documentation    Verify Dashboard extension:Multiple widgets function "delete widget" works
Resource    ../../../system_resource.robot

*** Variables ***
@{list_defult}   System Information   License    Administrators   CPU   Memory   Sessions   FortiCloud
${system_dashboard_vlan30_interface_remove_menu_popup_button}     xpath://div[div[widget-title[contains(text(),"Bandwidth")]//span="${FGT_VLAN30_INTERFACE}"]]/div[2]/button[3]
${system_dashboard_vlan20_interface_remove_menu_popup_button}     xpath://div[div[widget-title[contains(text(),"Bandwidth")]//span="${FGT_VLAN20_INTERFACE}"]]/div[2]/button[3]
${first_interface_remove_button}       xpath://div[48]/div[4]/button
#${second_interface_remove_button}      xpath://div[37]/div[4]/button

*** Test Cases ***
596506
##
    [Tags]    v6.0    chrome   596506    high    win10,64bit    browsers    norun
    
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
    Should Be Equal   "${exist}"    "True"
    ${interface}=   Set Variable  ${FGT_VLAN20_INTERFACE}
    system_Add_widget_bandwith    ${interface}
    ###check if interface widget appear in main page###
    ${exist}=    check if the Bandwidth of interface widget is appeared in the main page     ${interface}
    Should Be Equal   "${exist}"  "True"
    #### remove the widgets ####
    wait and click    ${system_dashboard_vlan30_interface_remove_menu_popup_button}
    wait and click    ${first_interface_remove_button}       
    
    ### after remove the first interface, the xpath for the first will be for the second ###
    wait and click    ${system_dashboard_vlan20_interface_remove_menu_popup_button}
    wait and click    ${first_interface_remove_button} 
    
    #### check if the interfaces are removed ####
    ${interface}=   Set Variable    ${FGT_VLAN30_INTERFACE}
    ${exist}=    check if the Bandwidth of interface widget is appeared in the main page    ${interface}
    Should Be Equal   "${exist}"    "False"
    ${interface}=   Set Variable    ${FGT_VLAN20_INTERFACE}
    ${exist}=    check if the Bandwidth of interface widget is appeared in the main page    ${interface}
    Should Be Equal   "${exist}"    "False"
    
    
    ###  reset to default ###
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_reset_dashboards_button}
    Wait and click     ${system_widget_setting_reset_dashboards_OK_button}
    check if the widget is reset to default    @{list_defult}    
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
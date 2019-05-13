*** Settings ***
Documentation      Verify some widgets are no longer available, some only single-added, some multi-added
Resource    ../../../system_resource.robot

*** Variables ***
@{list_added_widget_single-added}    Botnet Activity    HA Status    Sensor Information    Log Rate    Session Rate   Advanced Threat
@{list_defult}   System Information   Licenses   Administrators  CPU   Memory   Sessions
*** Test Cases ***
747964
##
    [Tags]    v6.0    chrome   747964    high    win10,64bit    browsers    runable    novm
    
    Login FortiGate     
    go to dashboard
    go to dashboard_main
    
    #check if the default widget is appeared in the main page 
    sleep  2
    ######  add the widget ##### 
    :FOR  ${element}    IN    @{list_added_widget_single-added}
         \  ${exist}=   Run keyword and return status   system_test_if_widget_exist  ${element}
         \  Run Keyword If    "${exist}"=="False"   system_Add_widget   ${element}
    system_click_widget_setting_button
    Wait and click      ${system_widget_setting_add_widget_button}

    ###  check if the added widget button is disabled after add ###
    :FOR  ${element}    IN    @{list_added_widget_single-added}
          \   ${widget_add_disabled}=    check if the widget button is add_disable    ${element}
          \   Should Be Equal   "${widget_add_disabled}"    "True"
    Wait and click      ${system_widget_setting_add_widget_close_button}

    #### add two interface bandwidth widget to confirm interface can be multi-added ####
    
        ${interface1}=    system_Add_widget_bandwith_firtst_interface_on_menu
        ${interface2}=    system_Add_widget_bandwith_second_interface_on_menu
    ###check if interface widget appear in main page###
        ${exist}=    check if the Bandwidth of interface widget is appeared in the main page    ${interface1}
           Should Be Equal   "${exist}"    "True"
        ${exist}=    check if the Bandwidth of interface widget is appeared in the main page    ${interface2}
           Should Be Equal   "${exist}"    "True"
    
    ###check if other widgets appear in main page###
    check if the added widget is appeared in the main page   @{list_added_widget_single-added}
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_reset_dashboards_button}
    Wait and click     ${system_widget_setting_reset_dashboards_OK_button}
    [Teardown]    case teardown
*** Keywords ***
case teardown   
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
*** Settings ***
Documentation    Verify in same (or New )dashboard tab some widget can only be added once
Resource    ../../../system_resource.robot

*** Variables ***
 @{list_added_widget}    Botnet Activity  
 @{list_defult}   System Information   License Status    Administrators  CPU   Memory   Sessions
 ${dashboard_name}     596510
 ${system_dashboard_newboard_entry}      xpath://span[text()="${dashboard_name}"]
*** Test Cases ***
596510
##
    [Tags]    v6.0    chrome   596510    high    win10,64bit    browsers    runable
    
    Login FortiGate     
    Go to Global
    Go to system
    go to dashboard
    go to dashboard_main
    
    #check if the default widget is appeared in the main page 
    sleep  2
    ######  add the widget ##### 
    :FOR  ${element}    IN    @{list_added_widget}
         \   ${exist}=   Run keyword and return status   system_test_if_widget_exist  ${element}
         \   Run keyword if   "${exist}"=="False"   system_Add_widget   ${element}
    #### check if the button is disbaled in the adding page
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_add_widget_button}
    :FOR  ${element}    IN     @{list_added_widget}
          \   ${widget_add_disabled}=    check if the widget button is add_disable    ${element}
          \   Should Be Equal  "${widget_add_disabled}"    "True"
    Wait and click     ${system_widget_setting_add_widget_close_button}   
    
    ###check if other widgets appear in main page###
    check if the added widget is appeared in the main page    @{list_added_widget}  
    ##### add a new dashboard and check if the widget can only added once in the new dashboard###
    go to dashboard
    go to dashboard_main
    system_click_widget_setting_button
    wait and click   ${system_widget_setting_add_dashboard_button}
    wait and click   ${system_widget_add dashboard_name_inputbox}
    Input Text       ${system_widget_add dashboard_name_inputbox}    ${dashboard_name}
    wait and click   ${system_widget_add dashboard_OK_button}
    wait and click   ${system_dashboard_newboard_entry}
    :FOR  ${element}    IN    @{list_added_widget}
         \   ${exist}=   Run keyword and return status   system_test_if_widget_exist  ${element}
         \   Run keyword if   "${exist}"=="False"   system_Add_widget   ${element}
    #### check if the button is disbaled in the adding page
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_add_widget_button}
    :FOR  ${element}    IN     @{list_added_widget}
          \   ${widget_add_disabled}=    check if the widget button is add_disable    ${element}
          \   Should Be Equal  "${widget_add_disabled}"    "True"
    Wait and click     ${system_widget_setting_add_widget_close_button}   
    ###check if other widgets appear in main page###
    check if the added widget is appeared in the main page    @{list_added_widget}  
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

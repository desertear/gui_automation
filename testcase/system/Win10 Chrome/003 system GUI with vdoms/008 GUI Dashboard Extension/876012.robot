*** Settings ***
Documentation      Verify vdom level reset dashboards works
Resource    ../../../system_resource.robot

*** Variables ***
${Fortiview_Title}    TEST123
@{list_added_widget}    Session Rate    
@{list_defult}    CPU   Memory   Sessions    
${dashboard_name}     876012
${system_dashboard_newboard_entry}      xpath://span[text()="${dashboard_name}"]
${system_widget_FortiView_widgetbanner}    xpath://widget-title[text()="${Fortiview_Title}"]
*** Test Cases ***
876012
##
    [Tags]    v6.0    chrome   876012    high    win10,64bit    browsers    runable
    
    Login FortiGate     
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}    
    sleep  2 
    go to dashboard
    go to dashboard_main
    
    #check if the default widget is appeared in the main page 
    sleep  2
    ######  add the widget ##### 
    :FOR  ${element}    IN    @{list_added_widget}
         \   ${exist}=   Run keyword and return status   system_test_if_widget_exist  ${element}
         \   Run keyword if   "${exist}"=="False"   system_Add_widget   ${element}
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_add_widget_button}

    :FOR  ${element}    IN    @{list_added_widget}
    \   ${widget_add_disabled}=    check if the widget button is add_disable    ${element}
    \   Should Be Equal   "${widget_add_disabled}"    "True"
    Wait and click         ${system_widget_setting_add_widget_close_button}   
    system_Add_widget_fortiview    ${Fortiview_Title}
    #### add interface ####
    ${interface}=    system_Add_widget_bandwith_firtst_interface_on_menu
    ###check if interface widget appear in main page###
    ${exist}=    check if the Bandwidth of interface widget is appeared in the main page    ${interface}
    Should Be Equal   "${exist}"    "True"
    ###check if other widgets appear in main page, fortiview banner is different with others###
    wait until Element Is Visible    ${system_widget_FortiView_widgetbanner}
    check if the added widget is appeared in the main page     @{list_added_widget} 
    
    ##### add a new dashboard
    go to dashboard
    go to dashboard_main
    system_click_widget_setting_button
    wait and click   ${system_widget_setting_add_dashboard_button}
    wait and click   ${system_widget_add dashboard_name_inputbox}
    Input Text       ${system_widget_add dashboard_name_inputbox}    ${dashboard_name}
    wait and click   ${system_widget_add dashboard_OK_button}
    wait and click   ${system_dashboard_newboard_entry}

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
    
#### userful loop after #####   
    # @{list}   System Information   Licenses   Administrators  CPU   Memory   Sessions
    # @{list_banner_in_main_page}
    # :FOR   ${element}    IN    @{list} 
    #     \    ${exist}=    Run keyword and return status    Wait Until Element Is Visible   ${system_widget_${widget_name}_widgetbanner}
    #     \    Run keyword if   "${exist}"=="True"   Append To List    @{list_banner_in_main_page}   1
    
    # :FOR   ${i}   IN RANGE  0   100
    #     \  ${exist}=   run keyword and return status  get from list   @{list_banner_in_main_page}  ${i}
    #     \  EXIT FOR LOOP IF   ${exist}=="False"
    #     \  ${x}=    get from list   @{list_banner_in_main_page}  ${i}
    #     \  ${j}=    Evaluate   ${j}+${x}
    # Should be Equal   ${j}   0

    

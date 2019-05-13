*** Settings ***
Documentation    Verify Global level reset dashboards works
Resource    ../../../system_resource.robot

*** Variables ***
 @{list_added_widget}    Botnet Activity  
 @{list_defult}   System Information   License Status    Administrators  CPU   Memory   Sessions
 ${dashboard_name}     596504
 ${system_dashboard_newboard_entry}      xpath://span[text()="${dashboard_name}"]
*** Test Cases ***
596504
##
    [Tags]    v6.0    chrome   596504    high    win10,64bit    browsers    runable
    
    Login FortiGate     
    Go to Global
    Go to system
    go to dashboard
    go to dashboard_main
    
    #check if the default widget is appeared in the main page 
    sleep  2
    ######  add the widget ##### 
    :FOR   ${element}    IN    @{list_added_widget}
         \   ${exist}=   Run keyword and return status   system_test_if_widget_exist  ${element}
         \   Run keyword if    "${exist}"=="False"   system_Add_widget   ${element}
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_add_widget_button}

    :FOR  ${element}    IN     @{list_added_widget}
          \   ${widget_add_disabled}=    check if the widget button is add_disable    ${element}
          \   Should Be Equal  "${widget_add_disabled}"    "True"
    Wait and click     ${system_widget_setting_add_widget_close_button}   
    
    #### add interface ####
    ${interface}=   Set Variable  ${FGT_VLAN30_INTERFACE}
    system_Add_widget_bandwith    ${interface}
    ###check if interface widget appear in main page###
    ${exist}=    check if the Bandwidth of interface widget is appeared in the main page    ${interface}
    Should Be Equal   "${exist}"    "True"
    ###check if other widgets appear in main page###
    check if the added widget is appeared in the main page    @{list_added_widget}  
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

# check if the widget button is add_disable 
#     [Arguments]   ${_widget_name}
#     Wait Until Element Is Visible    ${system_widget_setting_add_widget_${widget_name}_button}
#     ${if_disable}=  Run key word and return status   Get Element Attribute   ${system_widget_setting_add_widget_${widget_name}_button}    disabled
#     [Return]    ${if_disable}
    
# check if the added widget is appeared in the main page 
#     Wait Until Element Is Visible    ${system_widget_Botnet Activity_widgetbanner} 
#     Wait Until Element Is Visible    ${system_widget_HA Status_widgetbanner}   
#     Wait Until Element Is Visible    ${system_widget_sensorinfo_widgetbanner}  
#     Wait Until Element Is Visible    ${system_widget_Log Rate_widgetbanner}    
#     Wait Until Element Is Visible    ${system_widget_Session Rate_widgetbanner} 
#     Wait Until Element Is Visible    ${system_widget_Advanced Threat_widgetbanner} 

# check if the widget is reset to default
#     [Arguments]     @{list1}  
#     :FOR   ${element}    IN    @{list1} 
#         \    loop_for_waiting_element   ${element}
    
   

# loop_for_waiting_element
#     [Arguments]    ${widget_name}
#     :FOR   ${i}   IN RANGE   1    10
#         \    ${exist}=    Run keyword and return status    Wait Until Element Is Visible   ${system_widget_${widget_name}_widgetbanner}
#         \    EXIT FOR LOOP IF   "${exist}"=="True"
    
    
get element in add widget
     &{widget_dic}=    Create dictionary 
     :FOR  ${i}   IN RANGE   1   10
     \  ${exist}=    run keyword and return status    wait until element is Visible   xpath://form//div/section[${i}]  
     \  EXIT FOR LOOP IF  "${exist}"=="False"
     \  ${widget_dic}=    get button xpath   ${i}  ${widget_dic}
     [Return]   ${widget_dic}

get button xpath
    [Arguments]   ${i}  ${widget_dic}
     :FOR  ${j}   IN RANGE   1   10
     \  ${exist}=    run keyword and return status    wait until element is Visible   xpath://form//div/section[${i}]/button[${j}]  
     \  EXIT FOR LOOP IF  "${exist}"=="False"
     \  ${widget}=   set Variable   widget${i}_${j}
     \  Set To Dictionary   ${widget_dic}   ${widget}   xpath://form//div/section[${i}]/button[${j}] 
    [Return]   ${widget_dic}
    

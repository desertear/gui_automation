*** Settings ***
Documentation    Verify NOC dashboard widget can be resized vertically and horizontall
Resource    ../../../system_resource.robot

*** Variables ***
${dashboard_name}     824497
${system_dashboard_newboard_entry}      xpath://span[text()="${dashboard_name}"]
${system_dashboard_NOC_system_info_popup_resize_button}     xpath://f-system-information-widget//button[2]
${system_dashboard_NOC_system_info_resize_button}     xpath://button[div/span="Resize"]
${system_dashboard_NOC_system_info_orginal_size_info}      xpath://li[f-system-information-widget]
${system_dashboard_NOC_resize_first_widget_10x2}      xpath:(//f-block-resizer//div[10]/div[2])[1]

@{list_added_widget}    System Information   
*** Test Cases ***
824497
##
    [Tags]    v6.0    chrome   824497    high    win10,64bit    browsers    runable
    
    Login FortiGate     
    go to dashboard
    go to dashboard_main
    system_click_widget_setting_button
    wait and click   ${system_widget_setting_add_dashboard_button}
    wait and click   ${system_widget_add dashboard_NOC_label}
    wait and click   ${system_widget_add dashboard_name_inputbox}
    Input Text       ${system_widget_add dashboard_name_inputbox}    ${dashboard_name}
    Input Text       ${system_widget_add dashboard_Grid size_inputbox}    20
    wait and click   ${system_widget_add dashboard_OK_button}
    wait and click   ${system_dashboard_newboard_entry}
    sleep  2
    ######  add the widget ##### 
    :FOR  ${element}    IN    @{list_added_widget}
         \   ${exist}=   Run keyword and return status   system_test_if_widget_exist  ${element}
         \   Run keyword if   "${exist}"=="False"   system_Add_widget   ${element}
    
    check if the added widget is appeared in the main page    @{list_added_widget}  
    ${size_before}=    Get Element Attribute    ${system_dashboard_NOC_system_info_orginal_size_info}   style
    ${width_before}=   Fetch from right    ${size_before}    width:
    ${width_before}=   Fetch from left     ${width_before}   px; height
    ${height_before}=  Fetch from right    ${size_before}    height:
    ${height_before}=  Fetch from left     ${height_before}  px; left
    wait and click    ${system_dashboard_NOC_system_info_popup_resize_button}
    sleep  1
    ### change size of the widget and test if it work ####
    mouse over        ${system_dashboard_NOC_system_info_resize_button}
    wait and click    ${system_dashboard_NOC_resize_first_widget_10x2}
    sleep  2
    ${size_after}=     Get Element Attribute    ${system_dashboard_NOC_system_info_orginal_size_info}   style
    ${width_after}=    Fetch from right   ${size_after}    width:
    ${width_after}=    Fetch from left    ${width_after}   px; height
    ${height_after}=   Fetch from right   ${size_after}    height:
    ${height_after}=   Fetch from left    ${height_after}  px; left
    ${width_change}=   Evaluate   ${width_after}-${width_before}
    ${height_change}=  Evaluate   ${height_after}-${height_before}
    Should be True     ${width_change}>0
    Should be True     ${height_change}<0
    system_click_widget_setting_button
    wait and click     ${system_widget_setting_delete_dashboard_button}
    wait and click     ${system_widget_del dashboard_OK_button}
    sleep  2
    go to dashboard
    ${exist}=    Run keyword and Return status    wait Until Element Is Visible   ${system_dashboard_newboard_entry}
    Should be equal    "${exist}"     "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

    
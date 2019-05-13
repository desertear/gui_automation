*** Settings ***
Documentation    Verify add/delete dashboard works
Resource    ../../../system_resource.robot

*** Variables ***
${dashboard_name}     824496
${system_dashboard_newboard_entry}      xpath://span[text()="${dashboard_name}"]
@{list_added_widget}    System Information   License Status   Administrators   CPU   Memory   Sessions
*** Test Cases ***
824496
##
    [Tags]    v6.0    chrome   824496    high    win10,64bit    browsers    runable    env2fail
    
    Login FortiGate     
    go to dashboard
    go to dashboard_main
    system_click_widget_setting_button
    wait and click   ${system_widget_setting_add_dashboard_button}
    wait and click   ${system_widget_add dashboard_name_inputbox}
    Input Text       ${system_widget_add dashboard_name_inputbox}    ${dashboard_name}
    wait and click   ${system_widget_add dashboard_OK_button}
    wait and click   ${system_dashboard_newboard_entry}
    sleep  2
    ######  add the widget ##### 
    :FOR  ${element}    IN    @{list_added_widget}
         \   ${exist}=   Run keyword and return status   system_test_if_widget_exist  ${element}
         \   Run keyword if   "${exist}"=="False"   system_Add_widget   ${element}
    
    check if the added widget is appeared in the main page    @{list_added_widget}  
    system_click_widget_setting_button
    wait and click    ${system_widget_setting_delete_dashboard_button}
    wait and click    ${system_widget_del dashboard_OK_button}
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

    
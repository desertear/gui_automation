*** Settings ***
Documentation    Verify factory reset and "Reset Dashboards" will re-arrange widgets on the dashboard 
Resource    ../../../system_resource.robot

*** Variables ***
@{list_added_widget}    Botnet Activity  
@{list_defult}   System Information   License Status    Administrators  CPU   Memory   Sessions
*** Test Cases ***
712225
    [Tags]    v6.0    chrome   712225    Low    win10,64bit    browsers    runable   
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
    ###check if added widgets appear in main page###
    check if the added widget is appeared in the main page    @{list_added_widget}  
    ###  reset to default ###
    system_click_widget_setting_button
    Wait and click     ${system_widget_setting_reset_dashboards_button}
    Wait and click     ${system_widget_setting_reset_dashboards_OK_button}
    check if the widget is reset to default    @{list_defult}    
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    sleep  120
    Login FortiGate     
    Go to Global
    Go to system
    go to dashboard
    go to dashboard_main
    check if the widget is reset to default    @{list_defult}    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

*** Settings ***
Documentation    Verify multicore CPU usage supported by System Resources (or CPU) widget
Resource    ../../../system_resource.robot

*** Variables ***
${system_widget_CPU_Current usage_percore_button}    xpath://span[text()="Show per core CPU usage"]
${system_widget_CPU_Current usage_value}       xpath://f-cpu-usage-widget//span[text()="Current usage"]/following-sibling::span
${system_widget_CPU_Current usage_percore_menu_1 minute}   xpath://*[@id="navbar-view-section"]//div[1]/button/div/span
${system_widget_CPU_Current usage_percore_menu_10 minutes}   xpath://*[@id="navbar-view-section"]//div[2]/button/div/span
${system_widget_CPU_Current usage_percore_menu_30 minutes}   xpath://*[@id="navbar-view-section"]//div[3]/button/div/span
${system_widget_CPU_Current usage_percore_menu_1 hour}   xpath://*[@id="navbar-view-section"]//div[4]/button/div/span
${system_widget_CPU_Current usage_percore_menu_12 hours}   xpath://*[@id="navbar-view-section"]//div[5]/button/div/span
${system_widget_CPU_Current usage_percore_menu_24 hours}   xpath://*[@id="navbar-view-section"]//div[6]/button/div/span
${system_widget_CPU_Current usage_percore_core1_usage}     xpath://f-cpu-per-core-usage/div[2]/div[1]//span[2]
${system_widget_CPU_Current usage_percore_core2_usage}     xpath://f-cpu-per-core-usage/div[2]/div[2]//span[2]
${system_widget_CPU_Current usage_percore_core3_usage}     xpath://f-cpu-per-core-usage/div[2]/div[3]//span[2]
${system_widget_CPU_Current usage_percore_core4_usage}     xpath://f-cpu-per-core-usage/div[2]/div[4]//span[2]
${system_widget_CPU_Current usage_percore_menu_button}     xpath://f-cpu-per-core-usage/div/button
*** Test Cases ***
718834
##   Verify multicore CPU usage supported by System Resources (or CPU) widget
    [Tags]    v6.0    chrome   718834    High    win10,64bit    browsers    runable    novm
    
    Login FortiGate     
    Go to system
    go to dashboard
    go to dashboard_main
    wait and click    ${system_widget_CPU_Current usage_value}
    wait and click    ${system_widget_CPU_Current usage_percore_button}
    sleep   2s
    :FOR   ${i}    IN RANGE   1   7
    \  wait and click   ${system_widget_CPU_Current usage_percore_menu_button}
    \  wait and click   xpath://*[@id="navbar-view-section"]//div[${i}]/button/div/span
    \  sleep   1
    \  
    \  ${core1_usage}=   get text   ${system_widget_CPU_Current usage_percore_core1_usage}
    \  ${core2_usage}=   get text   ${system_widget_CPU_Current usage_percore_core2_usage}
    \  ${core3_usage}=   get text   ${system_widget_CPU_Current usage_percore_core3_usage}
    \  ${core4_usage}=   get text   ${system_widget_CPU_Current usage_percore_core4_usage}
    \  ${core1_usage}=   Fetch From Left   ${core1_usage}  %
    \  ${core2_usage}=   Fetch From Left   ${core2_usage}  %
    \  ${core3_usage}=   Fetch From Left   ${core3_usage}  %
    \  ${core4_usage}=   Fetch From Left   ${core4_usage}  %
    \  Capture Page Screenshot
    \  Should Be True    ${core1_usage}<10
    \  Should Be True    ${core2_usage}<10
    \  Should Be True    ${core3_usage}<10
    \  Should Be True    ${core4_usage}<10

    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

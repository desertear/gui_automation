*** Settings ***
Documentation    System resources widget, Verify CPU/Memory Real time view display correctly
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
703980
##   System resources widget, Verify CPU/Memory Real time view display correctly
    [Tags]    v6.0    chrome   703980    High    win10,64bit    browsers    norun
    ###  without traffic, cpu less than 25% and memory less than 50% is considerd good status  ###
    Login FortiGate    
    Go to system
    go to dashboard
    go to dashboard_main
    :FOR   ${i}    IN RANGE   1   7
      \  wait and click    ${system_widget_CPU_Current usage_term_menu_button}
      \  wait and click    xpath://div[24]/div[${i}]/button
      \  sleep   2
      \  wait and click    ${system_widget_Memory_Current usage_term_menu_button}
      \  sleep   2
      \  wait and click    xpath://div[27]/div[${i}]/button
      \  ${cpu_usage}=     get text   ${system_widget_CPU_Current usage_value} 
      \  ${memory_usage}=  get text   ${system_widget_memory_Current usage_value} 
      \  ${cpu_usage}=     Fetch From Left  ${cpu_usage}   %
      \  ${memory_usage}=  Fetch From Left   ${memory_usage}    %
      \  Should Be True    ${cpu_usage}<25
      \  Should Be True    ${memory_usage}<50
      \  sleep   2

    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

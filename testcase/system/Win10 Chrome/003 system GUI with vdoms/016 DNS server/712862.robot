*** Settings ***
Documentation    Verify option to enable/diable displaying DNS Database on NAT mode
Resource    ../../../system_resource.robot

*** Variables ***
${feature_name}
*** Test Cases ***
712862
    [Documentation]    
    [Tags]    v6.0    chrome   712862    High    win10,64bit    runable
    ##Verify option to enable/diable displaying DNS Database on NAT mode###
    Login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}    
    Go to system
    go to system_feature visibility
    sleep    2
    ${feature_name}=    Set Variable   DNS Database
    feature_vis_wait_for_feature_vis   ${feature_name}
    feature_vis_if_status_enabled      ${feature_name}
    ${enable_status_before}=    feature_vis_if_status_enabled   ${feature_name}
    ${enable_status_before_on_menu}=   check_display_on_menu  
    Should Be Equal   ${enable_status_before}   ${enable_status_before_on_menu}
    Go to system
    go to system_feature visibility
    feature_vis_click_status_button     ${feature_name}
    wait and click    ${system_feature_vis_apply_button}     
    ${enable_status_after}=    feature_vis_if_status_enabled   ${feature_name}
    ${enable_status_after_on_menu}=     check_display_on_menu  
    sleep   2s 
    Should Be Equal   ${enable_status_after}   ${enable_status_after_on_menu}
    
    Go to system
    go to system_feature visibility
    ${enable_status}=    feature_vis_if_status_enabled    ${feature_name}
    ${enable_status_change}=    Run keyword and return status   Should Not Be Equal   "${enable_status_before}"    "${enable_status}"
    Run keyword if   "${enable_status_change}"=="True"     feature_vis_click_status_button   ${feature_name}
    wait and click    ${system_feature_vis_apply_button}     
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

check_display_on_menu
    go to network
    ${display_status}=   Run Key word and return status    Wait and click    ${NETWORK_DNS Servers_ENTRY}
    sleep   2s
    [Return]   ${display_status}
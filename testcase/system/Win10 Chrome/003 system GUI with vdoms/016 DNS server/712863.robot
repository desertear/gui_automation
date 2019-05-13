*** Settings ***
Documentation    GUI:Verify no option to enable/diable displaying DNS Database on TP mode
Resource    ../../../system_resource.robot

*** Variables ***
${network_dns_ddns_interface_no entry}     xpath://div[@class="selection-pane"]//div[text()="No entries"]
*** Test Cases ***
712863
##[GUI] GUI:Verify no option to enable/diable displaying DNS Database on TP mode
    [Tags]    v6.0    chrome   712863    High    win10,64bit    browsers    system   runable
    Login FortiGate   
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}  
    
    sleep    2
    Go to system
    go to system_feature visibility
    sleep    2
    ${feature_name}=    Set Variable    DNS Database
    ${exist}=      feature_vis_wait_for_feature_vis    ${feature_name}
    ${exist}=      Convert to Integer   ${exist}
    ${status}=     Run keyword and return status   Evaluate   ${exist}>0
    Should be Equal    "${status}"   "True"
    feature_vis_if_status_enabled   ${feature_name}
    ${enable_status}=    feature_vis_if_status_enabled   ${feature_name}
    Run keyword if   "${enable_status}"=="False"    feature_vis_click_status_button     ${feature_name}
    Run keyword if   "${enable_status}"=="False"    wait and click    ${system_feature_vis_apply_button}     
    Go to network
    ${exist}=    run keyword and return status    Go to network_dns_server
    Should be equal    "${exist}"    "True"

    Go to VDOM    ${SYSTEM_TEST_VDOM_NAME_TP}    ${SYSTEM_TEST_VDOM_NAME_1}
    sleep    2
    Go to system
    go to system_feature visibility
    sleep    2
    ${feature_name}=    Set Variable    system_feature_vis_dnsdatabase
    ${exist}=    feature_vis_wait_for_feature_vis   ${feature_name}
    ${exist}=      Convert to Integer   ${exist}
    ${status}=     Run keyword and return status    Evaluate  ${exist}==0
    Should be Equal    "${status}"   "True"
    Go to network
    ${exist}=    run keyword and return status    Go to network_dns_server
    Should be equal    "${exist}"    "False"
    
    [Teardown]   case teardown

*** Keywords ***
case teardown
   Logout FortiGate
   Close All Browsers
   write test result to file    ${CURDIR}

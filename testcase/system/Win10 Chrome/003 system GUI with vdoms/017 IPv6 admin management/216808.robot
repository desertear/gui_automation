*** Settings ***
Documentation    GUI: verify  IPv6 administrative access http/https/telnet/ssh/ping/snmp by GUI
Resource    ../../../system_resource.robot

*** Variables ***
@{app_list}    https  http  ping  ssh  snmp
*** Test Cases ***
216808
    [Documentation]    
    [Tags]    v6.0    chrome   216808    High    win10,64bit    runable
    ##Verify option to enable/diable displaying DNS Database on NAT mode###
    Login FortiGate
    Go to system
    go to system_feature visibility
    sleep    2
    
    ${feature_name}=    Set Variable    IPv6
    ${enabled}=    Feature_vis_if_status_enabled_No row_col   ${feature_name}
    Run keyword if   "${enabled}"=="False"    Feature_vis_click_status_button_No row_col  ${feature_name}
    Run keyword if   "${enabled}"=="False"    wait and click    ${system_feature_vis_apply_button}  

    Go to network
    Go to network_Interfaces
    ${interfaces_select}=    network select interface    ${FGT_VLAN30_INTERFACE}
    wait and click    ${network_interfaces_edit_button}
    sleep   2
    :FOR  ${app}    IN    @{app_list}
        \   network_Interfaces_admin access_ipv6_select  ${app}
    
    wait and click    ${network_interfaces_edit_OK_button}
    unselect Frame
    
    ${interfaces_select}=    network select interface    ${FGT_VLAN30_INTERFACE}
    wait and click    ${network_interfaces_edit_button}
    sleep   2
    :FOR  ${app}    IN    @{app_list}
        \   ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_ADMINistrative ACESS_CHECKBOX_IPV6}    ${app}
        \   wait until element is visible   ${new_locator}
        \   Checkbox Should Be Selected   ${new_locator}
    
    Unselect Frame
    
    Go to system
    go to system_feature visibility
    sleep  2
    ${feature_name}=    Set Variable    IPv6
    ${enabled}=    Feature_vis_if_status_enabled_No row_col   ${feature_name}
    Run keyword if   "${enabled}"=="True"    Feature_vis_click_status_button_No row_col  ${feature_name}
    Run keyword if   "${enabled}"=="True"    wait and click    ${system_feature_vis_apply_button}  


    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}


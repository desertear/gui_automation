*** Settings ***
Documentation    GUI:Verify FGT can set IPv6 primary/secondary DNS server by gui
Resource    ../../../system_resource.robot

*** Variables ***
${network_interface_dns_ipv6_primary}    xpath://div[h2[contains(text(),"IPv6")]]/following-sibling::section/f-field[label="Primary DNS Server"]/div//input
${network_interface_dns_ipv6_secondary}    xpath://div[h2[contains(text(),"IPv6")]]/following-sibling::section/f-field[label="Secondary DNS Server"]/div//input
${FGT_DNS_SERVER1_IPV6}    2001:4860:4860::8888
${FGT_DNS_SERVER2_IPV6}    2000:172:16:100::100
*** Test Cases ***
216809
    [Documentation]    
    [Tags]    v6.0    chrome   216809    High    win10,64bit    runable
    ##Verify option to enable/diable displaying DNS Database on NAT mode###
    Login FortiGate
    Go to system
    go to system_feature visibility
    sleep    2
    
    ${feature_name}=    Set Variable    IPv6
    ${enabled}=    Feature_vis_if_status_enabled_No row_col   ${feature_name}
    Run keyword if   "${enabled}"=="False"    Feature_vis_click_status_button_No row_col  ${feature_name}
    Run keyword if   "${enabled}"=="False"    wait and click    ${system_feature_vis_apply_button}  
    sleep    2
    go to system_feature visibility
    go to system
    Go to network
    Go to network_dns
    wait and click   ${network_interface_dns_ipv6_primary}
    Input Text       ${network_interface_dns_ipv6_primary}    ${FGT_DNS_SERVER1_IPV6}
    wait and click   ${network_interface_dns_ipv6_primary}
    Input Text       ${network_interface_dns_ipv6_secondary}  ${FGT_DNS_SERVER2_IPV6}
    wait and click   ${network_dns_submit_apply_button}
    Unselect frame

    Go to network
    Go to network_Interfaces
    Go to network
    Go to network_dns
    Wait Until Element Is Visible         ${network_interface_dns_ipv6_primary}
    ${address}=    get element attribute  ${network_interface_dns_ipv6_primary}     value
    Should be equal   "${address}"       "${FGT_DNS_SERVER1_IPV6}"
    Wait Until Element Is Visible         ${network_interface_dns_ipv6_secondary}
    ${address}=    get element attribute  ${network_interface_dns_ipv6_secondary}   value
    Should be equal   "${address}"       "${FGT_DNS_SERVER2_IPV6}"
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}


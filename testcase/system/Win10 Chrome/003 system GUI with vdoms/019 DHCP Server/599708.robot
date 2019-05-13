*** Settings ***
Documentation    Verify dhcp server can be setup on certain interface by GUI.
Resource    ../../../system_resource.robot

*** Variables ***
${dhcp_server_interface}    ${FGT_PORT3_INTERFACE}
${start_ip_1}    10.1.200.115
${end_ip_1}      10.1.200.119
${start_ip_2}    10.1.200.125
${end_ip_2}      10.1.200.129
${start_ip_3}    10.1.200.135
${end_ip_3}      10.1.200.139
${start_ip_4}    10.1.200.145
${end_ip_4}      10.1.200.149
${netmask}       255.255.255.0
${dns}           8.8.8.8
@{ssh_cmd_clean}   killall -9 dhcpd
*** Test Cases ***
599708
    [Documentation]    
    [Tags]    v6.0    chrome   599708    Critical    win10,64bit    runable   
    [Setup]   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}init_dhcps_intf_cli.txt
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_clean}    port=${ssh_port}
    Login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${dhcp_server_interface} 
    wait and click   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   LAN
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    network edit interface  ${dhcp_server_interface} 
    Wait Until Element Is Visible    ${network_interface_dhcp_server_label}
    ${status}=   run keyword and return status     checkbox should be selected   ${network_interface_dhcp_server_enable button}
    run keyword if   "${status}"=="False"   wait and click   ${network_interface_dhcp_server_label}

    sleep    2
    ${startip_inputbox}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_startip}  1
    ${endip_inputbox}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_endip}    1
    ${entry}=             REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_entry}    1
    wait and click  ${entry}
    wait and click  ${network_interface_dhcp_server_address range_delete}
    
    
    :FOR  ${i}  IN RANGE   1   4
        \  wait and click  ${network_interface_dhcp_server_address range_create_new}
        \  ${entry}=             REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_entry}    ${i}
        \  ${startip_inputbox}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_startip}  ${i}
        \  ${endip_inputbox}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_endip}    ${i}
        \  wait and click  ${entry}
        \  clear element text   ${startip_inputbox}
        \  input text   ${startip_inputbox}   ${start_ip_${i}}
        \  clear element text   ${endip_inputbox}
        \  input text   ${endip_inputbox}   ${end_ip_${i}}
    ${disable}=         Get Element Attribute   ${network_interface_dhcp_server_address range_create new}  disabled
    should be equal    "${disable}"   "true"
    wait and click      ${network_interface_dhcp_server_netmask}
    clear element text  ${network_interface_dhcp_server_netmask}
    input text          ${network_interface_dhcp_server_netmask}   ${netmask}
    wait and click      ${NETWORK_INTERFACE_DHCP_SERVER_DNS_specify_LABEL}
    Wait Until Element Is Visible     ${network_interface_dhcp_server_dns_specify_ip}
    clear element text  ${network_interface_dhcp_server_dns_specify_ip}
    input text          ${network_interface_dhcp_server_dns_specify_ip}   ${dns}
    wait and click      ${submit_OK_button}
    unselect frame
    
    network edit interface  ${dhcp_server_interface}
    ${startip_inputbox}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_startip}   1
    ${endip_inputbox}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${network_interface_dhcp_server_address range_endip}     1
    ${entry}=             REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_entry}     1
    sleep  2
    wait and click      ${entry}
    wait and click      ${network_interface_dhcp_server_address range_edit}
    clear element text  ${startip_inputbox}
    input text          ${startip_inputbox}   ${start_ip_4}
    clear element text  ${endip_inputbox}
    input text          ${endip_inputbox}     ${end_ip_4}
    wait and click      ${network_interface_dhcp_server_address range_edit}
    wait and click      ${submit_OK_button}
    unselect frame

    network edit interface  ${dhcp_server_interface}
    :FOR  ${i}  IN RANGE   1   4
        \  ${entry}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_entry}   1
        \  wait and click  ${entry}

    :FOR  ${i}  IN RANGE   1   4
        \  ${entry}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDRESS RANGE_entry}   1
        \  wait and click  ${entry}
        \  wait and click  ${network_interface_dhcp_server_address range_delete}
    
    
    Wait Until Element Is Visible    ${network_interface_dhcp_server_label}
    ${status}=   run keyword and return status     checkbox should be selected   ${network_interface_dhcp_server_enable button}
    run keyword if   "${status}"=="True"   wait and click   ${network_interface_dhcp_server_label}
    wait and click    ${submit_OK_button}
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}clean_dhcps_intf_cli.txt
    write test result to file   ${CURDIR}


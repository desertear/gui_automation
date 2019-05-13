*** Settings ***
Documentation    Verify DHCP server monitor in GUI page.
Resource    ../../../system_resource.robot

*** Variables ***
${dhcp_server_interface}   ${FGT_PORT3_INTERFACE} 
${start_ip_1}    10.1.200.115
${end_ip_1}      10.1.200.119
${reserve_ip}    10.1.200.119
${dhcp_client}    ${FGTB_PORT3_INTERFACE}
${dhcp_client_mac}    ${FGTB_PORT3_MAC}
${netmask}       255.255.255.0
#@{ssh_cmd}       dhclient -r ${PC5_ETH1}    dhclient ${PC5_ETH1}   ifconfig ${PC5_ETH1} down    ifconfig ${PC5_ETH1} up   ifconfig
#@{ssh_cmd_clean}   ifconfig ${PC5_ETH1} 172.16.200.55     ifconfig ${PC5_ETH1} down    ifconfig ${PC5_ETH1} up
@{ssh_cmd_fgtb_init}     config global    config system interface    edit ${dhcp_client}     set mode static    set ip 0.0.0.0 0.0.0.0    end    end
@{ssh_cmd_fgtb_set}      config global    config system interface    edit ${dhcp_client}     set mode dhcp      end     end
@{ssh_cmd_fgtb_clean}    config global    config system interface    edit ${dhcp_client}     set mode static    set ip 0.0.0.0 0.0.0.0    end    end
@{placeholder_list}    ${reserve_ip}    ${dhcp_client_mac}
${dhcp_entry_xpath}   xpath://div[div[@column-id="ip"]/descendant::div[text()="\${PLACEHOLDER1}"]]/div[@column-id="mac"]/descendant::div[text()="\${PLACEHOLDER2}"]
@{ssh_cmd_clean}   killall -9 dhcpd
*** Test Cases ***
768689
    [Documentation]    
    [Tags]    v6.0    chrome   768689    Critical    win10,64bit    runable    env2fail
    [Setup]   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}init_dhcps_intf_cli.txt
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_clean}    port=${ssh_port}
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_init}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    Login FortiGate
    sleep   2
    Go to network
    go to network_Interfaces
    network edit interface  ${dhcp_server_interface} 
    wait and click   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   LAN
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    network edit interface       ${dhcp_server_interface} 
    Create Standard dhcp server  ${start_ip_1}   ${end_ip_1}   ${netmask}
    go to network_Interfaces
    network edit interface       ${dhcp_server_interface}  
    ${status}=   run keyword and return status   checkbox should be selected   ${network_interface_dhcp_server_enable button}
    run keyword if   "${status}"=="False"   wait and click   ${network_interface_dhcp_server_label}
    sleep  2
    ${status}=   run keyword and return status   checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
    run keyword if   "${status}"=="False"   wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL}
    wait and click  ${NETWORK_INTERFACE_DHCP_SERVER_MAC_RESV_CREATE_NEW}
    unselect frame
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_IPMAC_RESV_TYPE}     MAC Address
    wait and click        ${new_locator}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_IPMAC_RESV}    MAC address
    wait and click        ${new_locator}
    clear element text    ${new_locator}
    input text            ${new_locator}    ${dhcp_client_mac}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_IPMAC_RESV}    IP
    wait and click        ${new_locator}
    clear element text    ${new_locator}
    input text            ${new_locator}    ${reserve_ip}
    sleep   5
    wait and click        ${submit_OK_button}
    sleep   2
    select frame    ${NETWORK_FRAME}
    Capture Page Screenshot
    wait and click        ${submit_OK_button}
    unselect frame
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_set}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    sleep    10
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}  
    Go to Monitor
    Go to monitor_dhcp
    ${new_locator}=     REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE    ${dhcp_entry_xpath}    ${placeholder_list}
    :FOR  ${i}  IN RANGE   1   10
    \  ${exist}=   run keyword and return status   Wait Until Element Is Visible    ${new_locator}
    \  EXIT FOR LOOP IF   "${exist}"=="True"
    click element   ${new_locator}
    wait and click  ${MONITOR_DHCP_REVOKE_BUTTON}  
    ${exist}=   run keyword and return status   Wait Until Element Is Visible    ${new_locator}
    should be equal    "${exist}"    "False"
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}clean_dhcps_intf_cli.txt
    #Execute commands on PC via SSH connection    ${SSH_SERVER}    ${SSH_USERNAME}   ${SSH_PASSWORD}    ${ssh_cmd_clean}    port=${SSH_PORT}  
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_clean}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    write test result to file    ${CURDIR}


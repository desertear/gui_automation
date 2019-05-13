*** Settings ***
Documentation    Verify DHCP server IP/MAC reservation list can be edited by GUI.
Resource    ../../../system_resource.robot

*** Variables ***
${start_ip}   10.1.200.115
${end_ip}     10.1.200.119
${reserve_ip}    10.1.200.119
${netmask}       255.255.255.0
${dhcp_server_interface}     ${FGT_PORT3_INTERFACE}
${dhcp_client}    ${FGTB_PORT3_INTERFACE}
${dhcp_client_mac}      ${FGTB_PORT3_MAC}
@{ssh_cmd_fgtb_set}      config global    config system interface    edit ${dhcp_client}    set mode static    set ip 0.0.0.0 0.0.0.0    end     end
...                      config global    config system interface    edit ${dhcp_client}    set mode dhcp    end    end
@{ssh_cmd_fgtb_check}    config global    config system interface    edit ${dhcp_client}    get | grep ip
@{ssh_cmd_fgtb_clean}    config global    config system interface    edit ${dhcp_client}    set mode static    set ip 0.0.0.0 0.0.0.0    end    end
@{ssh_cmd_fgta_test}     config vdom    edit vdom1    show system dhcp server    
@{ssh_cmd_clean}   killall -9 dhcpd
${ip_reserve_page_ok_button}    xpath://button[@class="primary ng-scope"][@id="submit_ok"]
*** Test Cases ***
599709
    [Documentation]    
    [Tags]    v6.0    chrome   599709    Critical    win10,64bit    runable   env2fail 
    [Setup]   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}init_dhcps_intf_cli.txt
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_clean}    port=${ssh_port}
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_clean}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    Login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${dhcp_server_interface} 
    wait and click    ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   LAN
    wait and click    ${new_locator}
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame
    network edit interface         ${dhcp_server_interface}
    Create Standard dhcp server    ${start_ip}   ${end_ip}   ${netmask}
    network edit interface         ${dhcp_server_interface}
    ${status}=   run keyword and return status   checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
    run keyword if   "${status}"=="False"   wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL}
    wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_MAC_RESV_CREATE_NEW}
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
    Capture Page Screenshot
    sleep    5
    wait and click        ${ip_reserve_page_ok_button}
    select frame    ${NETWORK_FRAME}
    sleep    2
    wait and click        ${submit_OK_button}
    sleep    10
    Capture Page Screenshot
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgta_test}    telnet_port=${FGT_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGT_CLI_PROMPT}
    unselect frame
    sleep   2
    Go to network_Interfaces
    Go to network
    go to vdom    ${SYSTEM_TEST_VDOM_NAME_1}
    sleep   2
    Go to Monitor
    Go to Monitor_dhcp
    sleep   2
    Capture Page Screenshot
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_set}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    sleep    10
    @{responses_ssh}=     Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_check}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    ${response}=    set variable        @{responses_ssh}[-1]
    should match regexp   ${response}   ${reserve_ip}
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}clean_dhcps_intf_cli.txt
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_clean}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    write test result to file    ${CURDIR}



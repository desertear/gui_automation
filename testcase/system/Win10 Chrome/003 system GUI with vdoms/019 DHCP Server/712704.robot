*** Settings ***
Documentation    Verify VCI column in system->monitor->DHCP monitor page
Resource    ../../../system_resource.robot

*** Variables ***
${dhcp_server_interface}     ${FGT_PORT3_INTERFACE}
${dhcp_client_interface}     ${FGTB_PORT3_INTERFACE}
${start_ip_1}    10.1.200.115
${end_ip_1}      10.1.200.119
${reserve_ip}    10.1.200.119
${netmask}       255.255.255.0
${dhcp_entry_xpath}   xpath://div[contains(text(),"VCI:")]
@{ssh_cmd_FGT_A}   config vdom   edit ${SYSTEM_TEST_VDOM_NAME_1}   config sys dhcp server   edit 1   set vci-match enable   set vci-string "FGT"
@{ssh_cmd_FGT_B}   config global   config sys inter   edit ${dhcp_client_interface}   set mode dhcp   end 
@{ssh_cmd_FGT_B_clean}   config global   config system interface   edit ${dhcp_client_interface}   set mode static   set ip 0.0.0.0 0.0.0.0   end   end
@{ssh_cmd_clean}   killall -9 dhcpd

*** Test Cases ***
712704
    [Documentation]    
    [Tags]    v6.0    chrome   712704    High    win10,64bit    runable    
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
    network edit interface       ${dhcp_server_interface} 
    Create Standard dhcp server  ${start_ip_1}   ${end_ip_1}   ${netmask}
    Execute CLI commands on FortiGate Via Direct Telnet   ${ssh_cmd_FGT_A}    
    Execute CLI commands on FortiGate Via Direct Telnet   ${ssh_cmd_FGT_B}    ${SSH_SERVER_FGTB}   ${SSH_PORT_FGTB}    prompt=${FGTB_CLI_PROMPT} 
    sleep   60 
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}  
    Go to Monitor
    Go to monitor_dhcp
    :FOR  ${i}  IN RANGE   1   10
    \  ${exist}=   run keyword and return status   Wait Until Element Is Visible    ${dhcp_entry_xpath}
    \  EXIT FOR LOOP IF   "${exist}"=="True"
    click element    ${dhcp_entry_xpath}  
    sleep  2
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Execute CLI commands on FortiGate Via Direct Telnet   ${ssh_cmd_FGT_B_clean}    ${SSH_SERVER_FGTB}   ${SSH_PORT_FGTB}    prompt=${FGTB_CLI_PROMPT} 
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}clean_dhcps_intf_cli.txt
    write test result to file   ${CURDIR}


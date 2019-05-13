*** Settings ***
Documentation    Verify DHCP server Standard Options section in GUI page
...              norun because haven't know how to test  NTP is got by client
Resource    ../../../system_resource.robot


*** Variables ***
${dhcp_server_interface}    ${FGT_PORT3_INTERFACE} 
${start_ip_1}    10.1.200.115
${end_ip_1}      10.1.200.119
${reserve_ip}    10.1.200.119
${netmask}       255.255.255.0
${dhcp_NTP_server}   9.9.9.9
${dhcp_client}      ${FGTB_PORT3_INTERFACE} 
#@{ssh_cmd}   dhclient ${PC1_ETH1}   ifconfig ${PC1_ETH1} down    ifconfig ${PC1_ETH1} up   sleep 60   ifconfig
#@{ssh_cmd_clean}   ifconfig ${PC1_ETH1} 172.16.200.55     ifconfig ${PC1_ETH1} down    ifconfig ${PC1_ETH1} up

@{ssh_cmd_fgtb_set}      config global    config system interface    edit ${dhcp_client}     set mode static    set ip 0.0.0.0 0.0.0.0    end     end
...                      config global    config system interface    edit ${dhcp_client}     set mode dhcp    end    end
@{ssh_cmd_fgtb_check}    config global    config system interface    edit ${dhcp_client}     get | grep ip
@{ssh_cmd_fgtb_clean}    config global    config system interface    edit ${dhcp_client}     set mode static    set ip 0.0.0.0 0.0.0.0   end    end
@{ssh_cmd_clean}   killall -9 dhcpd
*** Test Cases ***
768685
    [Documentation]    
    [Tags]    v6.0    chrome   768685    Critical    win10,64bit   norun   
    [Setup]   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}init_dhcps_intf_cli.txt
    ## Haven't got the methord to test if NTP is received at client, so temporary norun
    ### config dhcp server ##
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
    network edit interface         ${dhcp_server_interface} 
    Create Standard dhcp server    ${start_ip_1}   ${end_ip_1}   ${netmask}
    ####  enable advanced and create addtional option ####
    go to network_Interfaces
    network edit interface   ${dhcp_server_interface}
    ${status}=   run keyword and return status     checkbox should be selected   ${network_interface_dhcp_server_enable button}
    run keyword if   "${status}"=="False"   wait and click   ${network_interface_dhcp_server_label}
    sleep  2
    ${status}=   run keyword and return status     checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
    run keyword if     "${status}"=="False"   wait and click   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL} 
    wait and click      ${NETWORK_INTERFACE_DHCP_SERVER_NTP_SPECIFY_BUTTON}
    wait and click      ${NETWORK_INTERFACE_DHCP_SERVER_NTP_SPECIFY_VALUE}
    clear element text  ${NETWORK_INTERFACE_DHCP_SERVER_NTP_SPECIFY_VALUE}
    input text          ${NETWORK_INTERFACE_DHCP_SERVER_NTP_SPECIFY_VALUE}   ${dhcp_NTP_server}
    wait and click      ${SUBMIT_OK_BUTTON}
    unselect frame
    #@{response_ssh}=    Execute commands on PC via SSH connection    ${SSH_SERVER}    ${SSH_USERNAME}   ${SSH_PASSWORD}    ${ssh_cmd}    port=${SSH_PORT}
    #${response}=    set variable    @{response_ssh}[-1]
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_set}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    sleep    10
    @{responses_ssh}=     Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_check}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    ${response}=    set variable        @{responses_ssh}[-1]
    should match regexp    ${response}   ${dhcp_NTP_server}  
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    #Execute commands on PC via SSH connection    ${SSH_SERVER}    ${SSH_USERNAME}   ${SSH_PASSWORD}    ${ssh_cmd_clean}    port=${SSH_PORT}  
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_clean}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}clean_dhcps_intf_cli.txt
    write test result to file    ${CURDIR}


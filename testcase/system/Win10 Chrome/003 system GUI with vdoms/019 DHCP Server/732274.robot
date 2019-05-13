*** Settings ***
Documentation    Verify Hostname information can be see at DHCP lease information on GUI
Resource    ../../../system_resource.robot

*** Variables ***
${start_ip}   10.1.200.115
${end_ip}     10.1.200.119
${reserve_ip}    10.1.200.119
${netmask}       255.255.255.0
${dhcp_server_interface}     ${FGT_PORT3_INTERFACE}
${dhcp_client}    ${FGTB_PORT3_INTERFACE}
${dhcp_entry_xpath}   xpath://div[contains(text(),"Hostname")]
#@{ssh_cmd}   dhclient ${PC1_ETH1}   ifconfig ${PC1_ETH1} down    ifconfig ${PC1_ETH1} up   
@{ssh_cmd_fgtb_set}      config global    config system interface    edit ${dhcp_client}    set mode static    set ip 0.0.0.0 0.0.0.0   end    end
...                      config global    config system interface    edit ${dhcp_client}    set mode dhcp    end    end
@{ssh_cmd_fgtb_clean}    config global    config system interface    edit ${dhcp_client}    set mode static    set ip 0.0.0.0 0.0.0.0    end    end
@{ssh_cmd_clean}   killall -9 dhcpd
*** Test Cases ***
732274
    [Documentation]    
    [Tags]    v6.0    chrome   732274    High    win10,64bit    runable    
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
    network edit interface        ${dhcp_server_interface} 
    Create Standard dhcp server   ${start_ip}   ${end_ip}   ${netmask}
    #${responses_ssh}=    Execute commands on PC via SSH connection    ${DCHP_CLIENT}    ${DCHP_CLIENT_USERNAME}   ${DCHP_CLIENT_PASSWORD}    ${ssh_cmd}    port=${DCHP_CLIENT_SSH_PORT} 
    #sleep   60 
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_set}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    sleep    10
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}  
    Go to Monitor
    Go to monitor_dhcp
    :FOR  ${i}  IN RANGE   1   10
    \  ${exist}=   run keyword and return status   Wait Until Element Is Visible    ${dhcp_entry_xpath}
    \  EXIT FOR LOOP IF   "${exist}"=="True"
    click element   ${dhcp_entry_xpath}  
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}clean_dhcps_intf_cli.txt
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_clean}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    write test result to file    ${CURDIR}


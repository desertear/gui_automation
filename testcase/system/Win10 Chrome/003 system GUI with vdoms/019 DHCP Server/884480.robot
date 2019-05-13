*** Settings ***
Documentation    Verify GUI support for reserving IP addresses using DHCP Option 82 (Relay Agent information, 534541)
Resource    ../../../system_resource.robot

*** Variables ***
${test_vlan}    30
${dhcp_server_interface}   ${FGT_VLAN${test_vlan}_INTERFACE}  
${start_ip_1}    172.16.200.115
${end_ip_1}      172.16.200.119
${reserve_ip}    172.16.200.119
${dhcp_client}    ${FGTB_VLAN${test_vlan}_INTERFACE}
${netmask}       255.255.255.0
${dhcp_client_mac}     ${FGTB_VLAN${test_vlan}_MAC}
#@{ssh_cmd}       dhclient -r ${PC5_ETH1}    dhclient ${PC5_ETH1}   ifconfig ${PC5_ETH1} down    ifconfig ${PC5_ETH1} up   ifconfig
#@{ssh_cmd_clean}   ifconfig ${PC5_ETH1} 172.16.200.55     ifconfig ${PC5_ETH1} down    ifconfig ${PC5_ETH1} up
@{ssh_cmd_fsw_get_mac}        get system status | grep MAC    

@{ssh_cmd_fgtswitch_init}    config switch interface     edit ${FSW_VLAN${test_vlan}_INTF_FGTA}    set dhcp-snooping trusted    end
...                          config switch interface     edit ${FSW_VLAN${test_vlan}_INTF_FGTB}    set dhcp-snooping trusted    end
...                          config switch vlan    edit ${test_vlan}    set dhcp-snooping enable    set dhcp-snooping-option82 enable   end

@{ssh_cmd_fgtswitch_clean}   config switch vlan    edit ${test_vlan}    set dhcp-snooping-option82 disable    set dhcp-snooping disable    end
...                          config switch interface     edit ${FSW_VLAN${test_vlan}_INTF_FGTA}    unset dhcp-snooping    end
...                          config switch interface     edit ${FSW_VLAN${test_vlan}_INTF_FGTB}    unset dhcp-snooping    end 

@{ssh_cmd_fgtb_init}     config global    config system interface    edit ${dhcp_client}     set mode static    set ip 0.0.0.0 0.0.0.0    end    end
@{ssh_cmd_fgtb_set}      config global    config system interface    edit ${dhcp_client}     set mode dhcp      end     end
@{ssh_cmd_fgtb_clean}    config global    config system interface    edit ${dhcp_client}     set mode static    set ip ${FGTB_VLAN${test_vlan}_IP} 255.255.255.0    end    end
@{ssh_cmd_fgta_clean}    config global    config system interface    edit ${FGT_VLAN${test_vlan}_INTERFACE}     set mode static    set ip ${FGT_VLAN${test_vlan}_IP} 255.255.255.0    end    end
@{placeholder_list}    ${reserve_ip}    ${dhcp_client_mac}
${dhcp_entry_xpath}   xpath://div[div[@column-id="ip"]/descendant::div[text()="\${PLACEHOLDER1}"]]/div[@column-id="mac"]/descendant::div[text()="\${PLACEHOLDER2}"]
@{ssh_cmd_clean}   killall -9 dhcpd     ifconfig ${PC5_ETH1} down
*** Test Cases ***
884480
    [Documentation]    
    [Tags]    v6.0    chrome   884480    Critical    win10,64bit    norun
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_clean}    port=${ssh_port}
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_init}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    #Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtswitch_init}    telnet_port=${FSW_TELNET_PORT_ON_TERMINAL_SERVER}
    # @{responses_ssh}=    Execute CLI commands on FortiGate Via Terminal Server    ${ssh_cmd_fsw_get_mac}     telnet_port=${FSW_TELNET_PORT_ON_TERMINAL_SERVER}    
    # ${response}=    set variable    @{responses_ssh}[-2]
    # ${mac}=    Fetch From Right     ${response}    MAC:
    # ${mac}=    get substring        ${mac}    1    18
    # ${mac}=    Strip String         ${mac} 
    #${remote_id}=    Set Variable   ${mac}
    ${remote_id}=    Set variable    906caca3a63a
    ${circuit_id_vlan}=    Convert To Hex    ${test_vlan}   length=4
    ${port}=    Fetch From Right    ${FSW_VLAN${test_vlan}_INTF_FGTB}    port
    ${port}=    Convert To Hex    ${port}   length=2
    ${circuit_id}=    Set variable    ${circuit_id_vlan}01${port}
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
    go to network_Interfaces
    network edit interface       ${dhcp_server_interface}  
    ${status}=   run keyword and return status   checkbox should be selected   ${network_interface_dhcp_server_enable button}
    run keyword if   "${status}"=="False"   wait and click   ${network_interface_dhcp_server_label}
    sleep  2
    ${status}=   run keyword and return status   checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
    run keyword if   "${status}"=="False"   wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL}
    wait and click  ${NETWORK_INTERFACE_DHCP_SERVER_MAC_RESV_CREATE_NEW}
    unselect frame
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_RESERVE_TYPE}    DHCP Relay
    wait and click        ${new_locator}
    sleep   1
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_RESERVE_ID_HEX}    Circuit
    wait and click        ${new_locator}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_RESERVE_ID_HEX_INPUT}    circuit
    wait and click        ${new_locator}
    clear element text    ${new_locator}
    input text            ${new_locator}    ${circuit_id}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_RESERVE_ID_HEX}    Remote
    wait and click        ${new_locator}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_RESERVE_ID_HEX_INPUT}    remote
    wait and click        ${new_locator}
    clear element text    ${new_locator}
    input text            ${new_locator}    ${remote_id}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACE_DHCP_SERVER_IPMAC_RESV}    IP
    wait and click        ${new_locator}
    clear element text    ${new_locator}
    input text            ${new_locator}    ${reserve_ip}
    wait and click        ${submit_OK_button}
    sleep   2
    select frame    ${NETWORK_FRAME}
    Capture Page Screenshot
    wait and click        ${submit_OK_button}
    unselect frame
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_set}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    sleep    20
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
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgta_clean}
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtswitch_clean}    telnet_port=${FSW_TELNET_PORT_ON_TERMINAL_SERVER}
    #Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_clean}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    write test result to file    ${CURDIR}


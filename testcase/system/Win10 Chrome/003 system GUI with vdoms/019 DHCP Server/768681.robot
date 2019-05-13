*** Settings ***
Documentation    Verify DHCP server Additional Option section in GUI page
Resource    ../../../system_resource.robot


*** Variables ***
${dhcp_server_interface}     ${FGT_PORT3_INTERFACE}
${start_ip_1}    10.1.200.115
${end_ip_1}      10.1.200.119
${reserve_ip}    10.1.200.119
${netmask}       255.255.255.0
${dhcp_client}    ${FGTB_PORT3_INTERFACE}
#@{ssh_cmd}   dhclient -r ${PC5_ETH1}    dhclient ${PC5_ETH1}   ifconfig ${PC5_ETH1} down    ifconfig ${PC5_ETH1} up   sleep 15   cat /etc/dhcp/dhclient.conf
#@{ssh_cmd_clean}   ifconfig ${PC5_ETH1} 172.16.200.55     ifconfig ${PC5_ETH1} down    ifconfig ${PC5_ETH1} up
@{ssh_cmd_fgtb_set}      config global    config system interface    edit ${dhcp_client}     set mode dhcp    end    end
@{ssh_cmd_fgtb_check}    config global    config system interface    edit ${dhcp_client}     get 
@{ssh_cmd_fgtb_clean}    config global    config system interface    edit ${dhcp_client}     set mode static    set ip 0.0.0.0 0.0.0.0    end    end
${value_Time Server}    172.16.200.254
${value_Name Server}    172.16.200.254
${value_Log Server}    172.16.200.254
${value_Host Name}    FortiGate
${value_Boot File}    6400
${value_Domain}    fortinet.com
${value_Swap}    172.16.200.254
${value_Lease Time}    6400
${value_File Name}    FortiGate_dhcp
${value_TFTP}   172.16.200.254
${sp_value_Specify (Hexadecimal)}   10
${sp_value_Specify (String)}   20
${sp_value_Specify (IP)}   30
${value_Specify (Hexadecimal)}   8.8.8.8
${value_Specify (String)}   8.8.8.8
${value_Specify (IP)}   8.8.8.8
${edit_value_Time Server}    172.16.200.55
${edit_value_Name Server}    172.16.200.55
${edit_value_Log Server}     172.16.200.55
${edit_value_Host Name}    google
${edit_value_Boot File}    3200
${edit_value_Domain}    google.com
${edit_value_Swap}    172.16.200.55
${edit_value_Lease Time}    3200
${edit_value_File Name}    FortiGate_ftp
${edit_value_TFTP}   172.16.200.55
@{list_option}     Time Server  Name Server   Log Server    Host Name   Boot File   Domain   Swap    File Name    TFTP   Specify (Hexadecimal)   Specify (String)   Specify (IP)
@{list_option_1}   Time Server  Name Server   Log Server    Host Name   Boot File   Domain   Swap    File Name    TFTP   Lease Time
@{list_option_2}   Time Server  Name Server   Log Server    Host Name   Boot File   Swap    File Name    Specify (Hexadecimal)   Specify (String)   Specify (IP)
@{ssh_cmd_clean}   killall -9 dhcpd
*** Test Cases ***
768681
    [Documentation]    
    [Tags]    v6.0    chrome   768681    Critical    win10,64bit    runable    
    [Setup]   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}init_dhcps_intf_cli.txt
    ### config dhcp server ##
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_clean}    port=${ssh_port}
    Login FortiGate
    sleep   2
    Go to network
    go to network_Interfaces
    sleep   2
    network edit interface  ${dhcp_server_interface} 
    wait and click   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   LAN
    wait and click   ${new_locator}
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    network edit interface       ${dhcp_server_interface} 
    Create Standard dhcp server  ${start_ip_1}   ${end_ip_1}   ${netmask}
    
    ####  enable advanced and create addtional option ####
    sleep   2
    network edit interface  ${dhcp_server_interface}     
    Wait Until Element Is Visible    ${network_interface_dhcp_server_label}
    ${status}=   run keyword and return status   checkbox should be selected   ${network_interface_dhcp_server_enable button}
    run keyword if   "${status}"=="False"   wait and click   ${network_interface_dhcp_server_label}
    ${status}=   run keyword and return status   checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
    run keyword if   "${status}"=="False"   wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL} 
   
    ${i}=   set variable   1
    :FOR  ${option}    IN    @{list_option}
         \   wait and click  ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_CREATE_NEW}
         \   ${status}=   run keyword and return status   should contain  ${option}   Specify
         \   ${new_select}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE  ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT}  ${i}
         \   wait and click  ${new_select}
         \   ${new_select_option}=   set variable   ${new_select}/option[contains(text(),"${option}")]
         \   wait and click  ${new_select_option}
         \   ${new_select_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT_VALUE}   ${i}
         \   Run keyword if  "${status}"=="False"   wait and click  ${new_select_value}
         \   Run keyword if  "${status}"=="False"   input text   ${new_select_value}    ${value_${option}}
         \   ${new_specify}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE        ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT_SPECIFY_VALUE}  ${i}
         \   Run keyword if  "${status}"=="True"    wait and click    ${new_specify}
         \   Run keyword if  "${status}"=="True"    input text        ${new_specify}    ${sp_value_${option}} 
         \   ${new_select_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT_VALUE}   ${i}
         \   ${status1}=   run keyword and return status   should not contain    ${option}   Specify (Hexadecimal)
         \   Run keyword if  "${status}"=="True" and "${status1}"=="True"     wait and click  ${new_select_value}
         \   Run keyword if  "${status}"=="True" and "${status1}"=="True"     input text   ${new_select_value}    ${value_${option}} 
         \   ${i}=   Evaluate  ${i}+1

    sleep   1
    wait and click  ${SUBMIT_OK_BUTTON}
    unselect frame

    ####  edit values ####
    Go to network
    go to network_Interfaces
    network edit interface  ${dhcp_server_interface}
    ${status}=   run keyword and return status   checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
    run keyword if   "${status}"=="False"   wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL} 
    :FOR  ${option}    IN     @{list_option_1}
         \   ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_SPAN}   ${option}
         \   wait and click   ${new_locator}  
         \   wait and click   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_EDIT}
         \   ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_VALUE_INPUT}   ${option}
         \   click element    ${new_locator}  
         \   clear element text   ${new_locator}  
         \   input text       ${new_locator}     ${edit_value_${option}}
    sleep   1
    wait and click  ${SUBMIT_OK_BUTTON}
    sleep   2
    unselect frame
    ##### test if the vlues are modified #####
    network edit interface  ${dhcp_server_interface}
    ${status}=   run keyword and return status   checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
    run keyword if   "${status}"=="False"   wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL} 
    :FOR  ${option}    IN     @{list_option_1}
         \   ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_VALUE_SPAN}   ${option}
         \   ${value_exist}=      GET TEXT    ${new_locator}
         \   should be equal    "${value_exist}"    "${edit_value_${option}}"

#     Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_set}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
#     sleep    10
#     @{responses_ssh}=     Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_check}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
#     ${response}=    set variable        @{responses_ssh}[-1]

    #@{response_ssh}=        Execute commands on PC via SSH connection    ${SSH_SERVER}    ${SSH_USERNAME}   ${SSH_PASSWORD}    ${ssh_cmd}    port=${SSH_PORT}  
    #${response}=    set variable    @{response_ssh}[-1]
    # should sniffer packets here...... to recognize if the options is sent.
    # should match regexp    ${response}   ${value_Domain}
    # should match regexp    ${response}   ${value_Host Name}
    ####  delete options  ##
    :FOR  ${option}    IN     @{list_option_2}
         \   ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_SPAN}   ${option}
         \   wait and click   ${new_locator}  
         \   wait and click   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_DELETE}
     wait and click  ${SUBMIT_OK_BUTTON}
     sleep    2
     ##  test if the options are deleted ##
     unselect frame
     network edit interface  ${dhcp_server_interface}
     ${status}=   run keyword and return status   checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
     run keyword if   "${status}"=="False"   wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL} 
     :FOR  ${option}    IN     @{list_option_2}
         \   ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_SPAN}   ${option}
         \   ${status}=    run keyword and return status    wait until element is Visible    ${new_locator}  
         \   should be equal    "${status}"    "False"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    #Execute commands on PC via SSH connection    ${SSH_SERVER}    ${SSH_USERNAME}   ${SSH_PASSWORD}    ${ssh_cmd_clean}    port=${SSH_PORT}  
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_clean}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}clean_dhcps_intf_cli.txt
    write test result to file    ${CURDIR}


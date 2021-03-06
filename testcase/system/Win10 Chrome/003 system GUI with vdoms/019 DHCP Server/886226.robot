*** Settings ***
Documentation    Verify DHCP server Additional Option section in GUI page
...              Fail with bug #0478472
Resource    ../../../system_resource.robot


*** Variables ***
${dhcp_server_interface}     ${FGT_PORT3_INTERFACE}
${start_ip_1}    10.1.200.115
${end_ip_1}      10.1.200.119
${netmask}       255.255.255.0
${dhcp_client}    ${FGTB_PORT3_INTERFACE}
${value_Domain}    fortinet.com
${value_TFTP}   172.16.200.254
@{list_option}     Domain   TFTP   
@{list_option_1}     Domain   TFTP   Lease Time
*** Test Cases ***
886226
    [Documentation]    
    [Tags]    Failcase!Bug#0478472    v6.0    chrome   886226    Medium     win10,64bit    runable   env2fail 
    [Setup]   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}init_dhcps_intf_cli.txt
    ### config dhcp server ##
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
         \   ${new_select}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE  ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT}  ${i}
         \   wait and click  ${new_select}
         \   ${new_select_option}=   set variable   ${new_select}/option[contains(text(),"${option}")]
         \   wait and click  ${new_select_option}
         \   ${new_select_value}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_SELECT_VALUE}   ${i}
         \   wait and click  ${new_select_value}
         \   input text   ${new_select_value}    ${value_${option}}
         \   ${i}=   Evaluate  ${i}+1

    sleep   1
    wait and click  ${SUBMIT_OK_BUTTON}
    unselect frame

    Go to network
    go to network_Interfaces
    network edit interface  ${dhcp_server_interface}
    ${status}=   run keyword and return status   checkbox should be selected   ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_BUTTON} 
    run keyword if   "${status}"=="False"   wait and click    ${NETWORK_INTERFACE_DHCP_SERVER_ADVANCED_LABEL} 
    :FOR  ${option}    IN     @{list_option_1}
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
     :FOR  ${option}    IN     @{list_option_1}
         \   ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACE_DHCP_SERVER_ADDITIONAL_OPTION_SPAN}   ${option}
         \   ${status}=    run keyword and return status    wait until element is Visible    ${new_locator}  
         \   should be equal    "${status}"    "False"
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}clean_dhcps_intf_cli.txt
    write test result to file    ${CURDIR}


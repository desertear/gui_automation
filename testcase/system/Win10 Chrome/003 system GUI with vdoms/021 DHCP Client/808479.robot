*** Settings ***
Documentation    Verify GUI prompt a warning message when IP conflict between static and dhcp interfaces
Resource    ../../../system_resource.robot

*** Variables ***
${fgtb_port3_dhcp_test_ip}   10.1.200.2
${start_ip}   10.1.200.1
${end_ip}   10.1.200.1
${dhcp_server_intf}    ${FGTB_PORT3_INTERFACE}
${dhcp_server_vdom}    ${FGB_VDOM_NAME_1}
@{ssh_cmd_FGT_B}   config global    config system global    set long-vdom-name enable    end    end     
...                config global   config sys interface  edit ${dhcp_server_intf}   set ip ${fgtb_port3_dhcp_test_ip}/255.255.255.0   
...                set vdom ${dhcp_server_vdom}    end   end   
...                config vdom   edit ${dhcp_server_vdom}   config sys dhcp server   edit 1   
...                config ip-range    edit 1   set start ${start_ip}    set end ${end_ip}   end   
...                set interface ${dhcp_server_intf}   set netmask 255.255.255.0   set default ${fgtb_port3_dhcp_test_ip}     end
@{ssh_cmd_FGT_B_clean}   config global    config system global    set long-vdom-name enable    end    end     
...                config vdom   edit ${dhcp_server_vdom}    config sys dhcp server    purge   end    end
...                config global   config sys interface   edit ${dhcp_server_intf}   set ip 0.0.0.0 0.0.0.0   end
@{ssh_cmd_clean}   killall -9 dhcpd
*** Test Cases ***
808479
    [Documentation]    
    [Tags]    v6.0    chrome   808479    High    win10,64bit    runable    env2fail
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_clean}    port=${ssh_port}
    login FortiGate
    ${responses_ssh}=     Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    sleep  30
    Go to network
    go to network_Interfaces
    network edit interface   ${FGT_PORT3_INTERFACE}
    wait and click   ${NETWORK_INTERFACE_ADDRESSING MODE_DHCP}
    wait and click   ${NETWORK_INTERFACES_EDIT_OK_BUTTON}
    unselect frame
    Go to network
    go to network_Interfaces
    network edit interface   ${FGT_PORT3_INTERFACE}
    sleep   30
    Reload Page
    unselect frame
    wait and click  ${SYSTEM_MAINBAR_NOTIFICATIONS_BUTTON}
    :FOR  ${i}   IN RANGE  2   10
        \   ${notifi_span}=  set Variable   ${SYSTEM_MAINBAR_NOTIFICATIONS_BUTTON_POPMENU}/div[${i}]/descendant::button//span
        \   ${exist}=        run keyword and return status   wait until element is visible   ${notifi_span}
        \   ${text}=         run keyword if   "${exist}"=="True"        get text   ${notifi_span}
        \   ${status}=       run Keyword and return status   should contain   ${text}   conflicts with the DHCP
        \   EXIT FOR LOOP IF    "${status}"=="True" or "${exist}"=="False"
    Should be equal   "${status}"    "True"
    wait and click  ${SYSTEM_MAINBAR_NOTIFICATIONS_BUTTON}

    [teardown]    case teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGT_B_clean}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

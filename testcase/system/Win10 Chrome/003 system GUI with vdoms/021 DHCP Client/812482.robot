*** Settings ***
Documentation    GUI: Verify show DNS setting when dhcp client set dns-server-override enable
...              Fail with bug #0528928
...              Fixed in B0812   ECO#136497
Resource    ../../../system_resource.robot

*** Variables ***
${url}    ${FGT_URL_VLAN30}
${fga_dhclient_int}    ${FGT_PORT3_INTERFACE}
${fgtb_port3_dhcp_test_ip}   10.1.200.2
${start_ip}   10.1.200.1
${end_ip}   10.1.200.1
${test_dns}   7.7.7.7
${dhcp_server_vdom}    ${FGB_VDOM_NAME_1}
${dhcp_server_intf}    ${FGTB_PORT3_INTERFACE}
@{ssh_cmd_FGT_B}   config global   config system interface    edit ${dhcp_server_intf}   
...                set ip ${fgtb_port3_dhcp_test_ip}/255.255.255.0   end   end   
...                config vdom   edit ${dhcp_server_vdom}   config sys dhcp server   edit 1   
...                config ip-range    edit 1   set start ${start_ip}    set end ${end_ip}   end   
...                set interface ${dhcp_server_intf}   set netmask 255.255.255.0   set default ${fgtb_port3_dhcp_test_ip}
...                set dns-service specify   set dns-server1 ${test_dns}  end   end
@{ssh_cmd_FGT_B_clean}   config vdom     edit ${dhcp_server_vdom}   config sys dhcp server    purge   end    end 
...                      config global   config system interface   edit ${dhcp_server_intf}   set ip 0.0.0.0 0.0.0.0   end    end
@{ssh_cmd_clean}   killall -9 dhcpd
${NETWORK_DNS_DNS_SERVER_DYNAMIC_OBTAIN}    xpath://tr[td[1]//span="${fga_dhclient_int}"]/td[div[text()="${test_dns}"]]
*** Test Cases ***
812482
    [Documentation]    
    [Tags]    FixedCase!   v6.0    chrome   812482    High    win10,64bit    runable    env2fail
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_clean}    port=${ssh_port}
    login FortiGate
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    sleep  30
    Go to network
    go to network_Interfaces
    network edit interface   ${fga_dhclient_int}
    sleep   2
    wait and click   ${NETWORK_INTERFACE_ADDRESSING MODE_DHCP}
    ${status}=  run keyword and return status   checkbox should be selected  ${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_CHECKBOX}
    run keyword if   "${status}"=="False"       wait and click               ${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_CHECKBOX}
    sleep   1
    wait and click   ${NETWORK_INTERFACES_EDIT_OK_BUTTON}
    unselect frame
    sleep   30
    go to network_dns
    wait until Element Is Visible    ${NETWORK_DNS_DNS_SERVER_DYNAMIC_OBTAIN}
    unselect frame
    Go to network
    go to network_Interfaces
    network edit interface  ${fga_dhclient_int}
    sleep   2
    wait until element is visible    ${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_LABEL}
    ${status}=        run keyword and return status  get element attribute   ${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_INPUT}   checked
    run keyword if   "${status}"=="True"           wait and click            ${NETWORK_INTERFACE_ADDRESSING MODE_DHCP_DNSOVER_LABEL}
    sleep   1
    wait and click   ${NETWORK_INTERFACES_EDIT_OK_BUTTON}
    unselect frame
    sleep   30
    Go to network
    go to network_dns
    ${status}=    run keyword and return status     wait until Element Is Visible    ${NETWORK_DNS_DNS_SERVER_DYNAMIC_OBTAIN}
    Should be equal    "${status}"    "False"
    unselect frame   
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGT_B_clean}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

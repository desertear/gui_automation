*** Settings ***
Documentation    Verify DHCPv6 Client can be enabled on interface by GUI
Resource    ../../../system_resource.robot

*** Variables ***
@{ssh_cmd_init}      killall -9 dhcpd   ifconfig ${PC5_ETH1} inet6 add ${PC5_VLAN30_IPV6}/64      dhcpd -6 -cf /etc/dhcp/dhcp6s-797012-vlan30.conf -lf /var/lib/dhcp/dhcpd6.leases ${PC5_ETH1} 
@{ssh_cmd_clean}   killall -9 dhcpd 
${response_string}    PID file: /var/run/dhcpd6.pid
@{cmd_list}     config global   config system interface    edit ${FGT_VLAN30_INTERFACE}    get | grep ip6-address
${test_tegx}    \s*:\s*2...:
*** Test Cases ***
768699
    [Tags]     v6.0    chrome   768699    High    win10,64bit    runable   
    Login FortiGate 
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_init}    port=${ssh_port}
    # sometime dhcpd already running
    #should contain    ${responses_ssh}   ${response_string}
    sleep  10
    go to system
    go to system_feature visibility
    enable_FGT_feature_noRC  IPv6
    sleep   2
    ### should select system menu first, then select "network", otherwise sometime web page got stale element
    go to system
    go to network
    Go to network_Interfaces
    network edit interface  ${FGT_VLAN30_INTERFACE}
    wait and click          ${NETWORK_INTERFACE_ADDRESSING MODE_IPV6_DHCP}
    wait and click          ${NETWORK_INTERFACES_EDIT_OK_BUTTON}
    sleep   60
    unselect frame
    TEST FROM CLI AND CHECK REGXP    ${cmd_list}   ${test_tegx}
    Go to system
    go to system_feature visibility
    sleep    2
    disable_FGT_feature_noRC    IPv6
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd_clean}    port=${ssh_port}
    write test result to file    ${CURDIR}
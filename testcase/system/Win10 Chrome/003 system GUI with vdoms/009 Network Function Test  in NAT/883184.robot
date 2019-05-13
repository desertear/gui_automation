*** Settings ***
Documentation    GUI:Verify the values obtained as DNS latency time in GUI and get dynamically updated for ipv4
Resource    ../../../system_resource.robot

*** Variables ***
@{ssh_cmd_fgtb_set}      config vdom    edit "${FGB_VDOM_NAME_1}"   config system dns-server    edit "${FGTB_VLAN30_INTERFACE}"    set mode non-recursive   end    end
@{ssh_cmd_fgtb_clean}    config vdom    edit "${FGB_VDOM_NAME_1}"   config system dns-server    edit "${FGTB_VLAN30_INTERFACE}"    unset mode    end    end
*** Test Cases ***
883184
    [Tags]    v6.0    chrome   883184    High    win10,64bit    browsers    system   runable  
    [Setup]   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_set}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    Login FortiGate   
    Go to network
    go to network_dns
    sleep   15
    Wait Until Element Is Visible        ${NETWORK_DNS_DNS SETTINGS_LATENCY_SECONDARY}
    test ipv4 dns latency   PRIMARY
    test ipv4 dns latency   SECONDARY
    [Teardown]   case teardown

*** Keywords ***
case teardown
   Logout FortiGate
   Close All Browsers
   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
   Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_clean}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
   write test result to file    ${CURDIR}


*** Settings ***
Documentation    GUI automation for SYSTEM feature
Resource        ./system_resource.robot
Suite Setup      Setup system_testing environment   ${ssh_cmd_pc1}   ${ssh_cmd_pc5}   ${ssh_cmd_fgt}
Suite teardown   Clear system_testing Environment
Test Timeout    20 min
Force Tags    system

*** Variables ***
@{ssh_cmd_pc1}    ifconfig |grep ${PC1_ETH1}
@{ssh_cmd_pc5}    ifconfig |grep ${PC5_ETH1}
@{ssh_cmd_fgt}    get system status | grep Hostname
@{ssh_cmd_fgtb_vlan20}   config global    config system interface    edit ${FGTB_VLAN20_INTERFACE}    get | grep macadd
@{ssh_cmd_fgtb_vlan30}   config global    config system interface    edit ${FGTB_VLAN30_INTERFACE}    get | grep macadd
@{ssh_cmd_fgtb_port3}    config global    config system interface    edit ${FGTB_PORT3_INTERFACE}     get | grep macadd
*** Keywords ***
Setup system_testing environment
    [Arguments]   ${ssh_cmd_pc1}    ${ssh_cmd_pc5}   ${ssh_cmd_fgt}
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}system_setup_cli.txt
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}system_setup_fgb_cli.txt     ${FGTB_TERMINAL_SERVER_IP}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}      prompt=${FGTB_CLI_PROMPT}
    @{responses_ssh}=    Execute commands on PC via SSH connection    ${PC5_VLAN10_IP}    ${SSH_USERNAME}   ${SSH_PASSWORD}    ${ssh_cmd_pc5}    port=${SSH_PORT}
    ${response}=    set variable    @{responses_ssh}[-1]
    ${mac}=    Fetch From Right     ${response}    HWaddr
    ${mac}=    get substring        ${mac}    1    18
    ${mac}=    Strip String         ${mac} 
    Set Global Variable    ${PC5_VLAN30_MAC}    ${mac}
    
    @{responses_ssh}=    Execute commands on PC via SSH connection    ${PC1_VLAN10_IP}    ${SSH_USERNAME}   ${SSH_PASSWORD}    ${ssh_cmd_pc1}    port=${SSH_PORT}
    ${response}=    set variable    @{responses_ssh}[-1]
    ${mac}=    Fetch From Right     ${response}    HWaddr
    ${mac}=    get substring        ${mac}    1    18
    ${mac}=    Strip String         ${mac} 
    Set Global Variable    ${PC1_VLAN20_MAC}    ${mac}
    
    @{responses_ssh}=    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgt}
    ${response}=    set variable       @{responses_ssh}[-1]
    ${hostname}=    Fetch From Right   ${response}    Hostname:
    ${hostname}=    Fetch From Left    ${hostname}    \r
    ${hostname}=    Strip String       ${hostname} 
    Set Global Variable    ${FGT_HOSTNAME}      ${hostname} 

    @{responses_ssh}=    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_vlan20}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    ${response}=    set variable       @{responses_ssh}[-1]
    ${mac_add}=     Fetch From Right   ${response}    addr
    ${mac_add}=     Fetch From LEFT    ${mac_add}     ${FGTB_HOSTNAME}
    ${mac_add}=     REPLACE STRING     ${mac_add}    :    ${EMPTY}    count=1
    ${mac_add}=     Strip String       ${mac_add}
    Set Global Variable    ${FGTB_VLAN20_MAC}      ${mac_add}
    
    @{responses_ssh}=    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_vlan30}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    ${response}=    set variable       @{responses_ssh}[-1]
    ${mac_add}=     Fetch From Right   ${response}    addr
    ${mac_add}=     Fetch From LEFT    ${mac_add}     ${FGTB_HOSTNAME}
    ${mac_add}=     REPLACE STRING     ${mac_add}    :    ${EMPTY}    count=1
    ${mac_add}=     Strip String       ${mac_add}
    Set Global Variable    ${FGTB_VLAN30_MAC}      ${mac_add}
  
    @{responses_ssh}=    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_fgtb_port3}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}  
    ${response}=    set variable       @{responses_ssh}[-1]
    ${mac_add}=     Fetch From Right   ${response}    addr
    ${mac_add}=     Fetch From LEFT    ${mac_add}     ${FGTB_HOSTNAME}
    ${mac_add}=     REPLACE STRING     ${mac_add}    :    ${EMPTY}    count=1
    ${mac_add}=     Strip String       ${mac_add}
    Set Global Variable    ${FGTB_PORT3_MAC}      ${mac_add}
Clear system_testing Environment
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}system_teardown_cli.txt
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}system_teardown_fgb_cli.txt   telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    prompt=${FGTB_CLI_PROMPT}
    

*** Settings ***
Documentation      Verify ethernet type vdom-link interface works for NAT and TP vdom, GUI
Resource    ../../../system_resource.robot

*** Variables ***
${fgta_test_int}    ${SYSTEM_TEST_INTF_4}
@{ssh_cmd_FGT_B_init}    config vdom    edit ${FGB_VDOM_NAME_1}    config system interface    edit ${FGTB_PORT4_INTERFACE}
...                      set vdom ${FGB_VDOM_NAME_1}    set ip 124.124.124.242 255.255.255.0    end     end

@{ssh_cmd_FGT_B_test}    config vdom    edit ${FGB_VDOM_NAME_1}    exec ping 124.124.124.241    end

@{ssh_cmd_FGT_B_clean}   config vdom    edit ${FGB_VDOM_NAME_1}    config system interface    edit ${FGTB_PORT4_INTERFACE}
...                set ip 0.0.0.0/0.0.0.0    end     end


@{ssh_cmd_FGT_a_test1}     config vdom    edit vdomtp    show firewall policy    end
@{ssh_cmd_FGT_a_test2}     config vdom    edit vdomtp    config sys inter    edit port16     show     end
@{ssh_cmd_FGT_a_test3}     config vdom    edit vdom1     config sys inter    edit 7324210    show     end
@{ssh_cmd_FGT_a_test4}     config vdom    edit vdom1     config sys inter    edit 7324211    show     end
${fgta_test_ip}    124.124.124.241/255.255.255.0
${test_interface_name}    732421
${ping_info}    icmp_seq=
*** Test Cases ***
732421
    [Tags]    v6.0    chrome   732421    High    win10,64bit    browsers    runable  
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    Run Cli commands in File   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B_init}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Login FortiGate
    sleep  2
    Go to network
    Go to network_Interfaces
    sleep    2
    Capture Page Screenshot 
    sleep    2
    Create Network vdom_link  ${test_interface_name}   ${SYSTEM_TEST_VDOM_NAME_1}  ${SYSTEM_TEST_VDOM_NAME_TP}  ${fgta_test_ip}    vdom_1_mode=TP
    ## check if the vdom-link is created
    unselect frame
    Go to network
    Go to network_Interfaces
    network select interface   ${test_interface_name}    ${test_interface_name}1    table_type=VDOM
    Capture Page Screenshot 
    ### create policy for TP vdom, so than FGTB can ping nat vdom ####
    unselect frame
    Go to network
    Go to network_Interfaces
    sleep    2
    Capture Page Screenshot 
    sleep    2
    Go to Global
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}
    Go to policy and objects
    Go to IPv4 policy
    system create ipv4 policy    732421in    ${test_interface_name}1     ${fgta_test_int} 
    system create ipv4 policy    732421out   ${fgta_test_int}            ${test_interface_name}1 
    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGT_a_test1}
    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGT_a_test2}
    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGT_a_test3}
    Execute CLI commands on FortiGate Via Direct Telnet     ${ssh_cmd_FGT_a_test4}
    sleep    2
    Capture Page Screenshot 
    sleep    2
    @{response_ssh}=      Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B_test}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    ${response}=    set variable    @{response_ssh}[-2]
    should match regexp    ${response}   ${ping_info}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  
    Run Cli commands in File     ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B_clean}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Close All Browsers
    write test result to file    ${CURDIR}

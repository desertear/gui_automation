*** Settings ***
Documentation    Verify SD-WAN options can be enable/disable 
Resource    ../../../system_resource.robot

*** Variables ***
${policy_name}    865964
${start_vlan}    100
${end_vlan}      200
${port3_gateway}    172.16.201.2
${sdw_interface_1}    ${SYSTEM_TEST_INTF_3}
${sdw_interface_2}    ${SYSTEM_TEST_INTF_1}
@{tel_cmd_FGT_B_init}    config global    config system global    set long-vdom-name enable    end    end 
...                config global    config system interface    edit ${FGTB_PORT3_INTERFACE}    set vdom ${FGB_VDOM_NAME_1}   
...                set ip 172.16.201.2 255.255.255.0    end    end 
...                config global    config system interface    edit ${FGTB_VLAN30_INTERFACE}   set vdom ${FGB_VDOM_NAME_1}   end    end                 
...                config vdom    edit ${FGB_VDOM_NAME_1}    config router static    edit 1    
...                set gateway 172.16.200.254   set device ${FGTB_VLAN30_INTERFACE}    end    end
@{tel_cmd_FGT_B_clean}    config vdom     edit ${FGB_VDOM_NAME_1}     config router static    delete 1   end   end
...                       config global    config system interface    edit ${FGTB_PORT3_INTERFACE}   set ip 0.0.0.0 0.0.0.0   end    end
*** Test Cases ***
865964
    [Documentation]    
    [Tags]    v6.0    chrome   865964    High    win10,64bit   runable    
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    ${response}=     Execute CLI commands on FortiGate Via Direct Telnet    ${tel_cmd_FGT_B_init}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    login FortiGate
    Go To Vdom        ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    go to network_SDWAN
    wait and click    ${NETWORK_SDWAN_ENABLE}
    Network Add interface to SDWAN    ${sdw_interface_1}    ${port3_gateway} 
    Network Add interface to SDWAN    ${sdw_interface_2}    ${FGT_VLAN30_GATEWAY}
    wait and click    ${SUBMIT_APPLY_BUTTON}
    Go to policy and objects
    Go to IPv4 policy
    system create ipv4 policy    ${policy_name}    ${SYSTEM_TEST_INTF_2}    SD-WAN
    sleep   2
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Execute CLI commands on FortiGate Via Direct Telnet    ${tel_cmd_FGT_B_clean}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}


*** Settings ***
Documentation    Verify Virtual Wire Pair can use aggregate interface as pair member
Resource    ../../../system_resource.robot

*** Variables ***
${vwp_name}    865966
${policy_name}    865966
${start_vlan}    100
${end_vlan}      200
@{phy_vwp_interface_1}    ${SYSTEM_TEST_INTF_3}
@{phy_vwp_interface_2}    ${SYSTEM_TEST_INTF_4}
${vwp_interface_1}    ${SYSTEM_TEST_INTF_3}
${vwp_interface_2}    ${SYSTEM_TEST_INTF_4}
@{tel_cmd_FGT_B_init}    config global    config system global    set long-vdom-name enable    end    end 
...                config global    config system interface    edit ${FGTB_PORT3_INTERFACE}   set vdom ${FGB_VDOM_NAME_1}   unset ip   end    end 
...                config global    config system interface    edit ${FGTB_PORT4_INTERFACE}   set vdom ${FGB_VDOM_NAME_2}   unset ip   end    end 
...
...                config vdom    edit ${FGB_VDOM_NAME_1}    config system interface   edit "aggtestv"   set vdom ${FGB_VDOM_NAME_1}
...                set type aggregate    set member "${FGTB_PORT3_INTERFACE}"   end    end    
...                config vdom    edit ${FGB_VDOM_NAME_1}    config firewall address   edit "aggtestv address" 
...                set type interface-subnet    set interface "aggtestv"    end   end
...                config vdom    edit ${FGB_VDOM_NAME_2}    config system interface   edit "aggtestr"   set vdom ${FGB_VDOM_NAME_2}
...                set type aggregate    set member "${FGTB_PORT4_INTERFACE}"   end    end
...                config vdom    edit ${FGB_VDOM_NAME_2}    config firewall address   edit "aggtestr address"
...                set type interface-subnet    set interface "aggtestr"    end   end
...
...                config vdom    edit ${FGB_VDOM_NAME_1}   config system interface    edit "vlan150v"        
...                set vdom "${FGB_VDOM_NAME_1}"     set ip 172.16.202.2 255.255.255.0    set allowaccess ping    
...                set role lan    set interface "aggtestv"    set vlanid 150    end    end  
...             
...                config vdom    edit ${FGB_VDOM_NAME_2}   config system interface    edit "vlan150r"      
...                set vdom "${FGB_VDOM_NAME_2}"     set ip 172.16.202.3 255.255.255.0    set allowaccess ping    
...                set role lan    set interface "aggtestr"    set vlanid 150    end    end

@{tel_cmd_FGT_B_test}     config vdom     edit ${FGB_VDOM_NAME_1}     execute ping 172.16.202.3
@{tel_cmd_FGT_B_clean}    config vdom     edit ${FGB_VDOM_NAME_1}     config system interface     delete "vlan150v"     end     end
...                       config vdom     edit ${FGB_VDOM_NAME_2}     config system interface     delete "vlan150r"     end     end
...
...                       config vdom     edit ${FGB_VDOM_NAME_1}     config firewall address     delete "aggtestv address"    end    end 
...                       config vdom     edit ${FGB_VDOM_NAME_1}     config system interface     delete "aggtestv"    end    end
...
...                       config vdom     edit ${FGB_VDOM_NAME_2}     config firewall address     delete "aggtestr address"     end    end 
...                       config vdom     edit ${FGB_VDOM_NAME_2}     config system interface     delete "aggtestr"    end    end


*** Test Cases ***
865966
    [Documentation]    
    [Tags]    v6.0    chrome   865966    High    win10,64bit    runable    
    ${response}=     Execute CLI commands on FortiGate Via Direct Telnet    ${tel_cmd_FGT_B_init}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    Create Network Interface   865966A   Agg   ${phy_vwp_interface_1}    
    Create Network Interface   865966B   Agg   ${phy_vwp_interface_2}    
    Create Network Vwp Interface    ${vwp_name}    865966A     865966B    100    200
    ### double check if the interface member is displayed on the selection menu, it should not be exist ###
    network edit interface  ${vwp_name}    table_type=Virtual Wire Pair
    wait until element is visible    ${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE}
    Mouse Over     ${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE}
    mouse out      ${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE}
    click element  ${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE} 
    ${staus}=      run keyword and return status    SELECT MENU BAR FROM SELECTION PANE    ${vwp_interface_1}
    should be equal  "${staus}"     "False"
    wait until element is visible    ${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE}
    Mouse Over     ${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE}
    mouse out      ${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE}      
    click element  ${NETWORK_INTERFACES_VWP_EDIT_VWP_INTERFACE} 
    ${staus}=    run keyword and return status    SELECT MENU BAR FROM SELECTION PANE    ${vwp_interface_2}
    should be equal  "${staus}"     "False"
    wait and click    ${SUBMIT_OK_BUTTON}
    ### config policy for VWP, reload the page first to let the menu bar appear ##
    Reload Page
    Go to policy and objects
    Go to Policy_IPV4_VWP_Policy
    wait and click      ${POLICY_IPV4_VWP_CREATE_NEW}
    Wait Until Element Is Visible    ${POLICY_IPV4_VWP_POLICY_NAME_LABEL}   
    click Element       ${POLICY_IPV4_VWP_POLICY_NAME_INPUT}
    clear element text  ${POLICY_IPV4_VWP_POLICY_NAME_INPUT}
    input text          ${POLICY_IPV4_VWP_POLICY_NAME_INPUT}    ${policy_name} 
    wait and click      ${POLICY_IPV4_VWP_POLICY_BIDIRECTION}
    
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_IPV4_VWP_POLICY_SERV}  Source
    wait and click      ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    all
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_IPV4_VWP_POLICY_SERV}  Destination
    wait and click      ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    all
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_IPV4_VWP_POLICY_SERV}  Service
    wait and click      ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    ALL
    wait and click      ${SUBMIT_OK_BUTTON}
    ###  test the connectivity of two interfaces of FGB which connect to the VWP ####
    @{response}=        Execute CLI commands on FortiGate Via Direct Telnet    ${tel_cmd_FGT_B_test}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    ${resp}=    set variable    @{response}[-1]
    should contain   ${resp}    icmp_seq
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Execute CLI commands on FortiGate Via Direct Telnet    ${tel_cmd_FGT_B_clean}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   
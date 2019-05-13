*** Settings ***
Documentation    Verify Vlan range filter on virtual wire pair can be enabled/disabled on GUI
Resource    ../../../system_resource.robot

*** Variables ***
${vwp_name}    850621
${policy_name}    850621
${start_vlan}    100
${end_vlan}      200
${vwp_interface_1}    ${SYSTEM_TEST_INTF_3}
${vwp_interface_2}    ${SYSTEM_TEST_INTF_4}
@{tel_cmd_FGT_B_init}    config global    config system global    set long-vdom-name enable    end    end 
...                 config vdom    edit ${FGB_VDOM_NAME_1}   config system interface    edit "vlan150v"    set vdom "${FGB_VDOM_NAME_1}"                   
...                 set ip 172.16.202.2 255.255.255.0    set allowaccess ping    
...                 set role lan    set interface "${FGTB_PORT3_INTERFACE}"    set vlanid 150    end    end               
...                 config vdom    edit ${FGB_VDOM_NAME_2}   config system interface    edit "vlan150r"    set vdom "${FGB_VDOM_NAME_2}"    
...                 set ip 172.16.202.3 255.255.255.0    set allowaccess ping    
...                 set role lan    set interface "${FGTB_PORT4_INTERFACE}"    set vlanid 150    end    end

@{tel_cmd_FGT_B_test}     config vdom     edit ${FGB_VDOM_NAME_1}    execute ping 172.16.202.3
@{tel_cmd_FGT_B_clean}    config vdom     edit ${FGB_VDOM_NAME_1}    config system interface     delete "vlan150v"     end     end
...                       config vdom     edit ${FGB_VDOM_NAME_2}    config system interface     delete "vlan150r"     end     end
*** Test Cases ***
850621
    [Documentation]    
    [Tags]    v6.0    chrome   850621    High    win10,64bit    runable    
    ${response}=     Execute CLI commands on FortiGate Via Direct Telnet    ${tel_cmd_FGT_B_init}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    Create Network Vwp Interface   ${vwp_name}   ${vwp_interface_1}     ${vwp_interface_2}     ${start_vlan}    ${end_vlan}
    ### config policy for VWP, reload the page first to let the menu bar appear ##
    Reload Page
    Go to network
    Go to policy and objects
    Go to Policy_IPV4_VWP_Policy
    wait and click      ${POLICY_IPV4_VWP_CREATE_NEW}
    Wait Until Element Is Visible    ${POLICY_IPV4_VWP_POLICY_NAME_LABEL}   
    click Element       ${POLICY_IPV4_VWP_POLICY_NAME_INPUT}
    clear element text  ${POLICY_IPV4_VWP_POLICY_NAME_INPUT}
    input text          ${POLICY_IPV4_VWP_POLICY_NAME_INPUT}    ${policy_name} 
    wait and click      ${POLICY_IPV4_VWP_POLICY_BIDIRECTION}
    
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_IPV4_VWP_POLICY_SERV}  Source
    wait and click    ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    all
    
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_IPV4_VWP_POLICY_SERV}  Destination
    wait and click    ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    all
    
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${POLICY_IPV4_VWP_POLICY_SERV}  Service
    wait and click    ${new_locator}
    SELECT MENU BAR FROM POLICY SELECTION PANE    ALL
    
    wait and click    ${SUBMIT_OK_BUTTON}
    ###  test the connectivity of two interfaces of FGB which connect to the VWP ####
    @{response}=      Execute CLI commands on FortiGate Via Direct Telnet    ${tel_cmd_FGT_B_test}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    ${resp}=    set variable    @{response}[-1]
    should contain   ${resp}    icmp_seq=1
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Execute CLI commands on FortiGate Via Direct Telnet    ${tel_cmd_FGT_B_clean}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   


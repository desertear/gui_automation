*** Settings ***
Documentation    [GUI] Verify GUI show warning message when editing an interface (physical,vlan,agg,run, etc) with an IP address that already exists on the network
Resource    ../../../system_resource.robot

*** Variables ***
${interface_aggre_name}    796221
@{phy_interface}    ${FGT_PORT3_INTERFACE} 
${network_interfaces_ipmask_error_label}       xpath://div[contains(text(),"This IP address is already in use")]
${ipmask}           ${FGTB_VLAN30_IP}/255.255.255.0
${ipmask_agg}       34.34.34.34/255.255.255.0
@{ssh_cmd_FGT_B_init}   config global    config system global      set long-vdom-name enable    end    end 
...                     config vdom      edit ${FGB_VDOM_NAME_1}   config system interface      edit aggtest   set vdom ${FGB_VDOM_NAME_1}
...                set type aggregate    set member ${FGTB_PORT3_INTERFACE}   set ip ${ipmask_agg}    end    end
...                config vdom    edit ${FGB_VDOM_NAME_1}
...                config firewall address   edit "aggtest address"   set type interface-subnet   set interface "aggtest"    end

@{ssh_cmd_FGT_B_clean}   config vdom   edit ${FGB_VDOM_NAME_1}   config firewall address   delete "aggtest address"
...                      end    end    config vdom    edit ${FGB_VDOM_NAME_1}    config system interface    delete "aggtest"    end    end
*** Test Cases ***

796221
    [Documentation]    
    [Tags]    v6.0    chrome   796221    High    win10,64bit    system  runable    env2fail
    ######
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B_init}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    Login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}     
    Go to network
    Go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_1}
    ### test physical interface ip duplicated on the network warning ####
    Wait Until Element Is Visible    ${network_interfaces_create or edit_IP Mask}
    clear element text      ${network_interfaces_create or edit_IP Mask}
    Input text              ${network_interfaces_create or edit_IP Mask}    ${ipmask}
    wait and click          ${NETWORK_INTERFACES_EDIT_ROLE_LABEL}
    sleep  2
    ${error_status}=    Run key word and return status    Wait until element is Visible    ${network_interfaces_ipmask_error_label}
    Should be Equal    "${error_status}"    "True"
    unselect frame
    Go to Global
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    Capture Page Screenshot
    # ${int_locator}=    network select interface     port15        
    # ${ref_locator}=    CATENATE  SEPARATOR=    ${int_locator}    ${NETWORK_INTERFACES_TABLE_REF}
    # wait and click   ${ref_locator}
    # Capture Page Screenshot
    # unselect frame
    Create Network Interface   ${interface_aggre_name}    Aggregate   ${phy_interface}
    network edit interface     ${interface_aggre_name}    table_type=Aggregate
    Wait Until Element Is Visible     ${network_interfaces_create or edit_IP Mask}
    clear element text  ${network_interfaces_create or edit_IP Mask}
    Input text          ${network_interfaces_create or edit_IP Mask}    ${ipmask_agg} 
    wait and click      ${NETWORK_INTERFACES_EDIT_ROLE_LABEL}
    ${error_status}=    Run key word and return status    Wait until element is Visible    ${network_interfaces_ipmask_error_label}
    Should be Equal    "${error_status}"    "True"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File     ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B_clean}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    write test result to file    ${CURDIR}


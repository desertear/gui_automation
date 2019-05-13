*** Settings ***
Documentation    Verify user can start/stop the capture for vlan, aggregate, redundant interfaces
Resource    ../../../system_resource.robot

*** Variables ***
${FGA_test_vdom}    ${SYSTEM_TEST_VDOM_NAME_1}
${FGB_test_vdom}    ${FGB_VDOM_NAME_1}
${capture_interface_vlan_name}     718826_vlan
@{capture_interface_aggre_name}    718826_Aggre
${capture_interface_redun_name}    718826_Redun
${capture_interface_vlan_ip}       172.16.201.1/255.255.255.0
${capture_interface_redun_ip}      172.16.202.1/255.255.255.0
@{phy_interface_agg}      ${FGT_PORT3_INTERFACE}   
@{phy_interface_redun}    ${FGT_PORT4_INTERFACE}
@{list_interface}     ${capture_interface_vlan_name}    ${capture_interface_redun_name}
@{ssh_cmd_FGT_B}   config global    config system global    set long-vdom-name enable    end    end 
...                config vdom    edit ${FGB_test_vdom}    config system interface    edit aggtest   set vdom ${FGB_test_vdom} 
...                set type aggregate    set member ${FGTB_PORT3_INTERFACE}   end   end    config vdom    edit ${FGB_test_vdom} 
...                config firewall address   edit "aggtest address"   set type interface-subnet   set interface "aggtest"    end

@{ssh_cmd_FGT_B_clean}   config vdom   edit ${FGB_test_vdom}    config firewall address   delete "aggtest address"
...                      end    end    config vdom    edit ${FGB_test_vdom}     config system interface    delete "aggtest"    end    end

*** Test Cases ***
718826
    [Documentation]    
    [Tags]    v6.0    chrome   718826    High    win10,64bit    runable
    ${responses_ssh}=     Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    login FortiGate    browser=chrome
    Go To Vdom     ${FGA_test_vdom} 
    Go to network
    Go to network_Interfaces
    Create Network Interface   ${capture_interface_aggre_name}   Aggregate  ${phy_interface_agg}
    sleep   2
    Create Network Interface   ${capture_interface_vlan_name}    VLAN       ${capture_interface_aggre_name}   ipmask=${capture_interface_vlan_ip}
    sleep   2
    Create Network Interface   ${capture_interface_redun_name}   Redun      ${phy_interface_redun}            ipmask=${capture_interface_redun_ip}
    sleep   2
    ### set interface into capture ####
    Go to network_packet_capture
    Set Capture interface      ${capture_interface_vlan_name}
    Set Capture interface      ${capture_interface_redun_name}
    ${i}=   Set Variable    1
    ### start to capture packets and check the cap file is downloaded ####
    :FOR  ${element}   IN    @{list_interface}
        \  select frame      ${NETWORK_FRAME}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}             ${element}
        \  wait and click    ${new_locator}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_START_BUTTON}      ${element}
        \  wait and click    ${new_locator}
        \  sleep  5
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_STOP_BUTTON}       ${element}
        \  wait and click    ${new_locator}
        \  Sleep  2
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_DOWNLOAD_BUTTON}   ${element}
        \  ${status}=    run keyword and return status    wait until element is visible  ${new_locator}
        \  run keyword if   "${status}"=="True"     wait and click     ${new_locator}
        \  run keyword if   "${status}"=="True"     sleep   10
        \  run keyword if   "${status}"=="True"     ftp file download should be done    ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${element}.${FGA_test_vdom}.${i}.pcap
        \  run keyword if   "${status}"=="True"     sleep   5
        \  run keyword if   "${status}"=="True"     Remove File      ${SYSTEM_FILE_DOWNLOAD_DIR_PATH}${/}${element}.${FGA_test_vdom}.${i}.pcap
        \  unselect frame
        \  ${i}=   Evaluate  ${i}+1

    ### delete captured interfaces####
    :FOR  ${element}   IN    @{list_interface}
        \  select frame      ${NETWORK_FRAME}
        \  ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${element}
        \  wait and click    ${new_locator}
        \  wait and click    ${NETWORK_PACKET_DELETE_BUTTON} 
        \  unselect frame
        \  wait and click    ${NETWORK_PACKET_DELETE_OK_BUTTON}     

    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Execute CLI commands on FortiGate Via Direct Telnet    ${ssh_cmd_FGT_B_clean}   ip_address=${FGTB_CLI_FGT_INTERNAL_IP}   prompt=${FGTB_CLI_PROMPT}
    write test result to file    ${CURDIR}

   


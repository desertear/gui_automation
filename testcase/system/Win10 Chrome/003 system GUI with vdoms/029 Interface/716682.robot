*** Settings ***
Documentation    Verify vlan interface show under physical interface when add a zone
Resource    ../../../system_resource.robot

*** Variables ***
@{phy_int}    ${SYSTEM_TEST_INTF_3}    
${vlan_phy_int}    ${SYSTEM_TEST_INTF_3}    
${vlan_1}    716682_VLAN100
${vlan_2}    716682_VLAN200
${zone_name}   716682
*** Test Cases ***
716682
    [Documentation]    
    [Tags]    v6.0    chrome   716682    Medium    win10,64bit    runable    interface
    login FortiGate    
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    Go to network
    Go to network_Interfaces
    Create Network Interface  ${vlan_1}   VLAN   ${phy_int}   100  
    Create Network Interface  ${vlan_2}   VLAN   ${phy_int}   200  
    ### create a zone
    select frame       ${NETWORK_FRAME}
    wait and click     ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    wait and click     ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_ZONE}
    wait until element is visible   ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME}
    sleep  1
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    clear element text  ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    input text          ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}     ${zone_name}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE        ${vlan_1}
    wait and click      ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE        ${vlan_2}
    wait and click      ${SUBMIT_OK_BUTTON}
    unselect frame
    network select interface   ${vlan_phy_int}   ${vlan_1}   
    unselect frame
    network select interface   ${vlan_phy_int}   ${vlan_2}      
    unselect frame
    network select interface   ${zone_name}      ${vlan_1}   table_type=Zone
    unselect frame
    network select interface   ${zone_name}      ${vlan_2}   table_type=Zone  
    unselect frame
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate 
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}





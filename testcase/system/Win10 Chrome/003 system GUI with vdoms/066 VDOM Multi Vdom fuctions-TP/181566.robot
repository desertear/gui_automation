*** Settings ***
Documentation    To verify To verify in TP mode, VLAN interface could be bound and unbound to a zone in GUI.
Resource    ../../../system_resource.robot

*** Variables ***
${vlan_name}    181566
${zone_name}    181566_zone
@{vlan_phy_int}    ${SYSTEM_TEST_INTF_3}
*** Test Cases ***
181566
    [Tags]    v6.0    chrome   181566   Critical     win10,64bit    browsers    runable   rest
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate    
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}
    Go to network
    Go to network_Interfaces
    Create Network Interface    ${vlan_name}   VLAN   ${vlan_phy_int}   100    vdom_mode_tp=yes
    ### create a zone
    unselect frame
    Go to network
    Go to network_Interfaces
    select frame      ${NETWORK_FRAME}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_MENU_BAR_ZONE}
    wait until element is visible   ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME}
    sleep  1
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    clear element text    ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}
    input text        ${NETWORK_INTERFACES_CREATE NEW_ZONE_NAME_INPUT}     ${zone_name}
    wait and click    ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE}
    SELECT MENU BAR FROM SELECTION PANE        ${vlan_name}
    wait and click    ${SUBMIT_OK_BUTTON}
    network edit interface    ${zone_name}    table_type=Zone
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_CREATE NEW_ZONE_INTERFACE_UNSELECT}   ${vlan_name}
    wait and click    ${new_locator}
    wait and click    ${SUBMIT_OK_BUTTON}    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

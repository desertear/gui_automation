*** Settings ***
Documentation    Verify GUI can "create address object" for interfaces with LAN or DMZ roles
Resource    ../../../system_resource.robot

*** Variables ***
@{phy_interface}    ${SYSTEM_TEST_INTF_3}

*** Test Cases ***
875459
    [Documentation]    
    [Tags]    v6.0    chrome   875459    High    win10,64bit    runable    
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    Create Network Interface  875459LAN   VLAN   ${phy_interface}   100   ipmask=172.16.201.1/255.255.255.0
    sleep   2
    Create Network Interface  875459DMZ   VLAN   ${phy_interface}   200   ipmask=172.16.202.1/255.255.255.0
    network edit interface  ${SYSTEM_TEST_INTF_3}   875459LAN   
    wait and click   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   LAN
    wait and click   ${new_locator}
    ${status}=       checkbox should be selected   ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_CHECKBOX}
    run Keyword if  "${status}"=="False"    wait and click    ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_LABEL}
    Wait Until Element Is Visible     ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_NAME}
    ${text}=         get text  ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_NAME}
    should contain   ${text}    875459LAN
    Wait Until Element Is Visible     ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_DEFINITION}
    ${text}=         get text  ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_DEFINITION}
    should contain   ${text}    172.16.201.0/24
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame

    network edit interface  ${SYSTEM_TEST_INTF_3}   875459DMZ   
    wait and click   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=  REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   DMZ
    wait and click   ${new_locator}
    ${status}=       checkbox should be selected   ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_CHECKBOX}
    run Keyword if  "${status}"=="False"    wait and click    ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_LABEL}
    Wait Until Element Is Visible     ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_NAME}
    ${text}=         get text  ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_NAME}
    should contain   ${text}    875459DMZ
    Wait Until Element Is Visible     ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_DEFINITION}
    ${text}=         get text  ${NETWORK_INTERFACES_EDIT_CREATE_ADDRESS_OBJ_DEFINITION}
    should contain   ${text}    172.16.202.0/24
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    network delete interface   ${SYSTEM_TEST_INTF_3}   875459LAN   
    sleep   2
    network delete interface   ${SYSTEM_TEST_INTF_3}   875459DMZ   
    sleep   2
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   


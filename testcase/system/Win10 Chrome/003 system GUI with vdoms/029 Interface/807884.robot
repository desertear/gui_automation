*** Settings ***
Documentation   Verify GUI changing interface to "LAN" role still have secondary IP settings
Resource    ../../../system_resource.robot

*** Variables ***
${master_ip}    172.16.201.1/255.255.255.0
${secondary_ip}   172.16.201.3/255.255.255.0
${secondary_ip_entry}      xpath://tr/td[contains(text(),"172.16.201.3")]
*** Test Cases ***
807884
    [Documentation]    
    [Tags]    v6.0    chrome   807884    High    win10,64bit    runable
    login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}
    ### set ip and secondary ip in WAN mode##
    wait and click    ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   WAN
    wait and click    ${new_locator}
    wait and click    ${NETWORK_INTERFACES_CREATE OR EDIT_IP Mask}
    clear element text    ${NETWORK_INTERFACES_CREATE OR EDIT_IP Mask}
    input text   ${NETWORK_INTERFACES_CREATE OR EDIT_IP Mask}    ${master_ip}
    ${status}=    run keyword and return status    checkbox should be selected    ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_CHECKBOX} 
    run keyword if   "${status}"=="False"    wait and click    ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_LABEL} 
    wait and click   ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_CREATE_NEW}
    wait and click   ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}
    clear element text    ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}
    input text   ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}    ${secondary_ip}
    wait and click   ${CONFIRM_OK_BUTTON}
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    ### change to LAN mode and double check if the secondary IP is still exist ##
    network edit interface  ${SYSTEM_TEST_INTF_3}
    wait and click    ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   LAN
    wait and click    ${new_locator}
    sleep   2
    Wait Until Element Is Visible     ${secondary_ip_entry}
    sleep   2
    unselect frame

    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

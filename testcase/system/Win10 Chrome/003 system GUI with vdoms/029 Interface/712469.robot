*** Settings ***
Documentation   GUI:Verify enable/disable secondary IP option works
Resource    ../../../system_resource.robot

*** Variables ***
${master_ip}    172.16.201.1/255.255.255.0
${secondary_ip_1}   172.16.201.3/255.255.255.0
${secondary_ip_1_entry}      xpath://tr/td[contains(text(),"172.16.201.3")]
${secondary_ip_2}   172.16.201.5/255.255.255.0
${secondary_ip_2_entry}      xpath://tr/td[contains(text(),"172.16.201.5")]
*** Test Cases ***
712469
    [Documentation]    
    [Tags]    v6.0    chrome   712469    High    win10,64bit    runable    interface
    login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}
    ### set ip and secondary ip in WAN mode##
    wait and click      ${NETWORK_INTERFACES_CREATE OR EDIT_IP Mask}
    clear element text  ${NETWORK_INTERFACES_CREATE OR EDIT_IP Mask}
    input text          ${NETWORK_INTERFACES_CREATE OR EDIT_IP Mask}    ${master_ip}
    ${status}=    run keyword and return status    checkbox should be selected    ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_CHECKBOX} 
    run keyword if     "${status}"=="False"    wait and click    ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_LABEL} 
    wait and click      ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_CREATE_NEW}
    wait and click      ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}
    clear element text  ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}
    input text          ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}    ${secondary_ip_1}
    wait and click      ${CONFIRM_OK_BUTTON}
    wait and click      ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_CREATE_NEW}
    wait and click      ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}
    clear element text  ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}
    input text          ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_INPUT}    ${secondary_ip_2}
    wait and click      ${CONFIRM_OK_BUTTON}
    wait and click      ${SUBMIT_OK_BUTTON}
    unselect frame
    ### change to LAN mode and double check if the secondary IP is still exist ##
    network edit interface  ${SYSTEM_TEST_INTF_3}
    Wait and click    ${secondary_ip_1_entry} 
    wait and click    ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_DELETE}
    Wait and click    ${secondary_ip_2_entry} 
    wait and click    ${NETWORK_INTERFACES_EDIT_SECONDARY_IP_DELETE}
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame
    network edit interface  ${SYSTEM_TEST_INTF_3}
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${secondary_ip_1_entry} 
    should be equal    "${status}"    "False"
    ${status}=    run keyword and return status    Wait Until Element Is Visible    ${secondary_ip_2_entry} 
    should be equal    "${status}"    "False"
    sleep   2
    unselect frame

    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

*** Settings ***
Documentation    [GUI]  Verify Fortigate Interface GUI page does not support PPPoE in middle to high End Models
Resource    ../../../system_resource.robot

*** Variables ***
${case_number}       731980
${interface_name}    731980
@{py_interface}    ${SYSTEM_TEST_INTF_4}
${interface}       ${SYSTEM_TEST_INTF_4}
${expand_status}
${network_interfaces_table_physical_interface_case_number}     xpath://td/span[b="${case_number}"]
@{type_list}     VLAN     Soft    
*** Test Cases ***
731980
    [Documentation]    
    [Tags]    v6.0    chrome   731980    High    win10,64bit    system   runable
    ######
    Login FortiGate
    Go to Global
    Go to network
    Go to network_Interfaces
    network edit interface     ${interface}
    ${exist}=    Run Keyword and return status   wait until Element Is Visible     ${network_interface_addressing mode_pppoe}
    Should Be Equal   "${exist}"    "False"
    #### test if pppoe exist in a new created interface ####
    wait and click    ${network_interfaces_create or edit_Interface_Cancel_Button}
    unselect frame
    Go to network_Interfaces
    ###  create vlan software switch, to confirm there is no pppoe  ####
    :FOR  ${element}    IN    @{type_list}
        \   Create Network Interface   ${interface_name}   ${element}          ${py_interface}
        \   network edit interface     ${interface}        ${interface_name}   ${element}
        \   ${exist}=    Run Keyword and return status   wait until Element Is Visible     ${network_interface_addressing mode_pppoe}
        \   Should Be Equal  "${exist}"    "False"
        \   wait and click   ${SUBMIT_OK_BUTTON}
        \   unselect frame
        \   run Keyword if  "${element}"=="VLAN"    network delete interface   ${interface}     ${interface_name}
    
    Unselect frame
   
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}


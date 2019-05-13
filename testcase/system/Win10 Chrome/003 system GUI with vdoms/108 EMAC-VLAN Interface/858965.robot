*** Settings ***
Documentation   Verify limitation that emac-vlan interface can't be supported on dedicated management interface (CLI/GUI) 
Resource    ../../../system_resource.robot

*** Variables ***
${test_emac}    858965_emac
@{list_test_ph_intf}    mgmt
${test_ph_intf}    mgmt
${vlan_id_emac}   100
*** Test Cases ***
858965
    [Documentation]    
    [Tags]    v6.0    chrome   858965    Low     win10,64bit    runable   novm
    login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface    ${test_ph_intf}
    ${status}=   run keyword and return status   Checkbox should be selected   ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_CHECKBOX}
    run keyword if    "${status}"=="False"   wait and click     ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_BUTTON}
    wait and click    ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_TRUST_HOST}
    clear element text     ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_TRUST_HOST}
    input text    ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_TRUST_HOST}   10.10.10.10
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame
    ${status}=    run keyword and return status    Create Network Interface  ${test_emac}  type=EMAC  physical_interface=${list_test_ph_intf}  vlan_id=${vlan_id_emac} 
    should be equal    "${status}"    "False"
    unselect frame
    Go to network
    go to network_Interfaces
    network edit interface    ${test_ph_intf}
    ${status}=   run keyword and return status   Checkbox should be selected   ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_CHECKBOX}
    run keyword if    "${status}"=="True"   wait and click     ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_BUTTON}
    wait and click    ${SUBMIT_OK_BUTTON}
    unselect frame
    ${status}=    run keyword and return status    Create Network Interface  ${test_emac}  type=EMAC  physical_interface=${list_test_ph_intf}  vlan_id=${vlan_id_emac} 
    should be equal    "${status}"    "True"
    network select interface  main_interface_name=${test_emac}    table_type=EMAC
    unselect frame
    sleep  2
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

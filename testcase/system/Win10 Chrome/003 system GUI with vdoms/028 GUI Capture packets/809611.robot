*** Settings ***
Documentation   Failcase!  bug #0303566
...             Verify change 'dedicated-to' settings for mgmt interface won't cause packet capture task removed on GU
Resource    ../../../system_resource.robot

*** Variables ***
${capture_interface}    mgmt

*** Test Cases ***
809611
    [Documentation]    
    [Tags]    Failcase!Bug#0303566    v6.0    chrome   809611    High    win10,64bit    runable    env2fail
    login FortiGate
    Go To Vdom              ${SYSTEM_TEST_VDOM_NAME_2}
    Go to network
    Go to network_packet_capture
    Set Capture interface   ${capture_interface}
    Go to network
    Go to network_Interfaces
    network edit interface  ${capture_interface}
    ${status}=          run keyword and return status   Checkbox should be selected   ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_CHECKBOX}
    run keyword if     "${status}"=="False"   wait and click     ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_BUTTON}
    wait and click      ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_TRUST_HOST}
    clear element text  ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_TRUST_HOST}
    input text          ${NETWORK_INTERFACES_EDIT_MGMT_DEDICATED_TRUST_HOST}   10.10.10.10
    wait and click      ${SUBMIT_OK_BUTTON}
    unselect frame
    Go to network
    Go to network_packet_capture
    select frame        ${NETWORK_FRAME}
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_PACKET_CAPTURE_SNIFFER_ITEMS}    ${capture_interface}
    wait and click     ${new_locator}
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

*** Settings ***
Documentation   Verify estimated-upstream-bandwidth and estimated-downstream-bandwidth can be set on GUI when interface role is wan
Resource    ../../../system_resource.robot

*** Variables ***
${upstream_band}    100000
${downstream_band}  100000
*** Test Cases ***
808405
    [Documentation]    
    [Tags]    v6.0    chrome   808405    High    win10,64bit    runable
    login FortiGate
    Go to network
    go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}  
    ### change the interface staus to WAN, input estimated bandwidth ####
    wait and click       ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=      REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   WAN
    wait and click       ${new_locator}
    wait Until Element Is Visible     ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_LABEL}
    wait and click       ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}
    clear element text   ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}
    input text           ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}      ${upstream_band}   
    clear element text   ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}
    input text           ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}    ${downstream_band}   
    wait and click       ${SUBMIT_OK_BUTTON}
    unselect frame

    network edit interface  ${SYSTEM_TEST_INTF_3}  
    wait Until Element Is Visible         ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_LABEL}
    ${value}=    get element attribute    ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}      value
    should be equal     "${value}"       "${upstream_band}"
    ${value}=    get element attribute    ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}    value
    should be equal     "${value}"       "${downstream_band}"

    wait and click      ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENU}
    ${new_locator}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_EDIT_ROLE_SELECT_MENUBAR}   Undefined
    wait Until Element Is Visible  ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_LABEL}
    wait and click      ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}
    clear element text  ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}
    input text          ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}      ${upstream_band}   
    clear element text  ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}
    input text          ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}    ${downstream_band}   
    wait and click      ${SUBMIT_OK_BUTTON}
    unselect frame

    network edit interface  ${SYSTEM_TEST_INTF_3}  
    wait Until Element Is Visible     ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_LABEL}
    ${value}=     get element attribute      ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}        value
    should be equal   "${value}"    "${upstream_band}"
    ${value}=     get element attribute      ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}      value
    should be equal   "${value}"    "${downstream_band}"
    ###  set value to default  ###
    wait and click      ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}
    clear element text  ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}
    input text          ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_UP}      0
    clear element text  ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}
    input text          ${NETWORK_INTERFACES_EDIT_ESTINAMTE_BANDWIDTH_DOWN}    0
    wait and click      ${SUBMIT_OK_BUTTON}
    unselect frame
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

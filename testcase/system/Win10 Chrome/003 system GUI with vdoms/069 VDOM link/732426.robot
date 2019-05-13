*** Settings ***
Documentation      Verify NPU_vdom_link interface can be enable/disable on GUI
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
732426
    [Tags]    v6.0    chrome   732426    High    win10,64bit    browsers    runable   novm
    Login FortiGate
    sleep  2
    Go to network
    Go to network_Interfaces
    network edit interface  npu0_vlink    table_type=VDOM  
    :FOR   ${i}   IN RANGE   0   2
        \  ${new_locator_div}=     REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_VDOMLINK_INT_DIV}  Interface ${i}
        \  ${enable_chbx}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_VDOMLINK_INT_DIV_STATE_INPUT}   Enabled
        \  ${enable_label}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_VDOMLINK_INT_DIV_STATE_label}   Enabled
        \  ${enable_chbx}=    Catenate     SEPARATOR=     ${new_locator_div}    ${enable_chbx}
        \  ${enable_label}=   Catenate     SEPARATOR=     ${new_locator_div}    ${enable_label}
        \  ${disable_chbx}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_VDOMLINK_INT_DIV_STATE_INPUT}   Disabled
        \  ${disable_label}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${NETWORK_INTERFACES_VDOMLINK_INT_DIV_STATE_label}   Disabled
        \  ${disable_chbx}=    Catenate     SEPARATOR=     ${new_locator_div}    ${disable_chbx}
        \  ${disable_label}=   Catenate     SEPARATOR=     ${new_locator_div}    ${disable_label}
        \  wait and click    ${disable_label}
        \  wait and click    ${enable_label}
        \  ${status}=   get element attribute    ${enable_chbx}    class
        \  should contain    "${status}"     ng-valid-parse
        \  wait and click    ${disable_label}
        \  ${status}=   get element attribute    ${disable_chbx}    class
        \  should contain    "${status}"     ng-valid-parse
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  
    Close All Browsers
    write test result to file    ${CURDIR}

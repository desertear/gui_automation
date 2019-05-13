*** Settings ***
Documentation    Verify GUI support 0.0.0.0-x.x.x.x iprange object (M415326)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${test_address}   0.0.0.0-192.168.254.255
*** Test Cases ***
840152
    [Documentation]
    [Tags]    chrome    840152    high
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_2}
    Go to policy and objects
    Go to Addresses
    create new addresses  category=Address  address_name=${TEST NAME}  type=IP Range  address_value=${test_address}  interface=${FW_TEST_INTF_3}
    if address exists    ${TEST NAME}
    delete address    ${TEST NAME}
    Logout FortiGate

*** Keywords ***

case Teardown
    write test result to file    ${CURDIR}

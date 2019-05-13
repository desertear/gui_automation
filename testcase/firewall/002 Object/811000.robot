*** Settings ***
Documentation    Verify Virtual WAN link member is available for VIP and VIP group creation (M305444)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
811000
    [Documentation]
    [Tags]    chrome    811000    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
    Go to Virtual IP

# Step 1: Virtual WAN link member is available for VIP Creation
    Log    ==================== Step 1: Virtual WAN link member is available for VIP Creation ====================
    Click Create New on Virtual IP List
    Click Element    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_DIV}
    Element Should Contain    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTION}    ${FW_TEST_INTF_3}
    Element Should Contain    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTION}    ${FW_TEST_INTF_4}
    Click Element    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTED}
    Click Cancel Button on Virtual IP Editor 

# Step 2: Virtual WAN link member is available for VIP Group Creation
    Log    ==================== Step 2: Virtual WAN link member is available for VIP Group Creation ====================
    Click Create New on Virtual IP List    Virtual IP Group
    Click Element    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_DIV}
    Element Should Contain    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTION}    ${FW_TEST_INTF_3}
    Element Should Contain    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTION}    ${FW_TEST_INTF_4}
    Click Element    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTED}
    Click Cancel Button on Virtual IP Editor

    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

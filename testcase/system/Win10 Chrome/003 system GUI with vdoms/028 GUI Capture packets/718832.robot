*** Settings ***
Documentation    Verify vdom-admin only see and create a new capture for their vdom interface
Resource    ../../../system_resource.robot

*** Variables ***
${capture_interface}   ${SYSTEM_TEST_INTF_4}
@{list_interface}      ${SYSTEM_TEST_INTF_1}     ${SYSTEM_TEST_INTF_2}     ${SYSTEM_TEST_INTF_3}
*** Test Cases ***
718832
    [Documentation]    
    [Tags]    v6.0    chrome   718832    Medium    win10,64bit    runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate    username=718832    password=123
    Go to network
    Go to network_packet_capture
    :FOR    ${element}   IN     @{list_interface}
       \    ${status}=   run key word and return status    Set Capture interface     ${element}
       \    should be equal    "${status}"    "True"
    ${status}=   run key word and return status    Set Capture interface     ${capture_interface}
    should be equal   "${status}"    "False"
    wait and click     ${DROPDOWN_MASK}    
    wait and click     ${SUBMIT_CANCEL_BUTTON}
    unselect frame
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate   username=718832
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

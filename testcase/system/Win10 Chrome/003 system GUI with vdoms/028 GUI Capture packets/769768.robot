*** Settings ***
Documentation    Verify admin without packet-capture permission can not sniffer packets
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
769768
    [Documentation]    
    [Tags]    v6.0    chrome   769768    Medium    win10,64bit    runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate    username=769768    password=123
    Go to network
    ${status}=   run keyword and return status   Go to network_packet_capture
    should be equal     "${status}"    "False"
    [teardown]    case teardown
 
*** Keywords ***
case Teardown
    Logout FortiGate   username=769768
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

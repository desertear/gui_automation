*** Settings ***
Documentation      Verify NPU_vdom_link will NOT show on GUI/CLI when vdom not enabled
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
732424
    [Tags]    v6.0    chrome   732424    High    win10,64bit    browsers    runable      rest
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}novdom_setup_cli.txt
    Login FortiGate
    sleep  2
    Go to network
    Go to network_Interfaces
    ${status}=   run keyword and return status   network select interface  npu0_vlink    table_type=VDOM  
    should be equal    "${status}"     "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

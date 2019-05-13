*** Settings ***
Documentation      GUI:Verify Hide VDOM field when not in VDOM mode
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
712831
##
    [Tags]    v6.0    chrome   712831    high    win10,64bit    browsers    runable      test10
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}novdom_setup_cli.txt
    Login FortiGate    
    ${status}=   run keyword and return status    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_2}
    should be equal   "${status}"    "False"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    write test result to file    ${CURDIR}


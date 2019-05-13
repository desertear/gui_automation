*** Settings ***
Documentation    [GUI] Verify DDNS doesn't be supported on pure TP mode
...              Failcase with bugs #298484, Forti DDNS should not show on the page
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
713644
##[GUI] Verify DDNS doesn't be supported on pure TP mode
    [Tags]    Failcase!Bugs#298484   v6.0    chrome   713644    High    win10,64bit    browsers    system   runable   
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    sleep   60
    Login FortiGate   
    Go to network
    Go to network_dns
    ${exist}=    Run Keyword and return status    wait until element is Visible    ${NETWORK_DNS_DDNS_ENABLE_LABEL}
    Should be equal    "${exist}"   "False"
    [Teardown]   case teardown
*** Keywords ***
case teardown
   Logout FortiGate
   Close All Browsers
   ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
   Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
   ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
   write test result to file    ${CURDIR}
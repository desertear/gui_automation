*** Settings ***
Documentation      To verify vdom admin can view interfaces/dns pages without error when vdom not enabled
Resource    ../../../system_resource.robot

*** Variables ***
@{vdom}      ${SYSTEM_TEST_VDOM_NAME_2}
*** Test Cases ***
796255
    [Tags]    v6.0    chrome   796255    high    win10,64bit    browsers    runable      test10
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}novdom_setup_cli.txt
    Login FortiGate   
    Go to system
    sleep  2
    Go to System_administrators
    Create Administrator  796255  123    admin_profile=prof_admin   vdom=${vdom}   none_vdom=yes
    unselect frame
    Logout FortiGate  
    Login FortiGate  username=796255  password=123
    go to network
    Go to network_Interfaces
    select frame   ${NETWORK_FRAME}
    Wait Until Element Is Visible    ${NETWORK_INTERFACES_CREATE NEW_BUTTON}
    unselect frame
    Go to network
    go to network_dns
    sleep  15
    wait until element is visible    ${NETWORK_DNS_DNS SETTINGS_DNS_SERVER_LABEL}
    sleep  2
    Logout FortiGate   username=796255 
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    write test result to file    ${CURDIR}

*** Settings ***
Documentation    Verify GUI main dashboard and interface page works well when login with super admin after enable split vdom(0504450)
Resource    ../../../system_resource.robot

*** Variables ***
@{list_defult}   System Information   License Status    Administrators  CPU   Memory   Sessions
@{list_defult_vdom}   Security Fabric    CPU    Memory    Sessions
*** Test Cases ***
878972
    [Tags]    v6.0    chrome   878972    High    win10,64bit    browsers    runable   rest
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}splitvdom_setup_cli.txt
    Login FortiGate   
    Go to Global
    go to dashboard
    go to dashboard_main
    #check if the default widget is appeared in the main page 
        :FOR   ${element}    IN    @{list_defult}
         \     system_test_if_widget_exist  ${element}
    go to network
    Go to network_Interfaces    
    ${count_global}=    COUNT INTERFACES OF VDOM    ${SYSTEM_TEST_VDOM_NAME_TRAFFIC}
    sleep  2
    unselect frame 
    go to network
    go to vdom   ${SYSTEM_TEST_VDOM_NAME_TRAFFIC}
    go to dashboard
    go to dashboard_main
    #check if the default widget is appeared in the main page 
        :FOR   ${element}    IN    @{list_defult_vdom}
         \     system_test_if_widget_exist  ${element}
    go to network
    Go to network_Interfaces
    ${count_vdom}=    COUNT INTERFACES OF VDOM    ${SYSTEM_TEST_VDOM_NAME_TRAFFIC}
    should be equal   "${count_global}"    "${count_vdom}"
    unselect frame
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  
    Close All Browsers
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    write test result to file    ${CURDIR}

    

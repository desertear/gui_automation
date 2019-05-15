*** Settings ***
Documentation    Verify GUI main dashboard and interface page works well when login with readonly admin after enable split vdom
Resource    ../../../system_resource.robot

*** Variables ***
${username}    878974
${pro_name}    878974
${password}    123
@{list_defult_vdom}   Security Fabric    CPU    Memory    Sessions
@{vdom}    ${SYSTEM_TEST_VDOM_NAME_TRAFFIC}  
*** Test Cases ***
878974
    [Tags]    v6.0    chrome   878974    High    win10,64bit    browsers    runable      rest
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}splitvdom_setup_cli.txt
    Login FortiGate
    Go to system
    go to system_admin_profiles
    Create Admin Profile   name=${pro_name}   access=Read  
    Go to System_administrators
    Create Administrator  username=${username}   password=${password}  vdom=${vdom}  admin_profile=${pro_name}
    Logout FortiGate  
    Login FortiGate   username=${username}   password=${password} 
    go to dashboard
    go to dashboard_main
    #check if the default widget is appeared in the main page 
        :FOR   ${element}    IN    @{list_defult_vdom}
         \     system_test_if_widget_exist  ${element}
    sleep  2
    go to network
    Go to network_Interfaces
    ${count_vdom}=    COUNT INTERFACES OF VDOM    ${SYSTEM_TEST_VDOM_NAME_TRAFFIC}
    should be equal   "${count_vdom}"    "4"
    unselect frame
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate    username=${username}
    Close All Browsers
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    write test result to file    ${CURDIR}

    

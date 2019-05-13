*** Settings ***
Documentation      Verify FGT system information,embedded console,system resource,unit operation are correct on status page with a vdom admin.
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   590368
@{list_defult}   Security Fabric   CPU   Memory   Sessions
*** Test Cases ***
590368
    [Tags]    v6.0    chrome   590368    High    win10,64bit    browsers    runable   rest
    [Setup]   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate  username=${admin_name}  password=123
    sleep   2
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    go to dashboard
    go to dashboard_main
    sleep  2
    check if the widget is reset to default    @{list_defult}  
    unselect frame
    popup embed console 
    go to embed console
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  username=${admin_name}
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

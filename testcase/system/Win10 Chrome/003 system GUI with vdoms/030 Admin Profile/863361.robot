*** Settings ***
Documentation    Verify GUI main dashboard and interface page works well when login with vdom admin
Resource    ../../../system_resource.robot

*** Variables ***
@{list_defult}   Security Fabric   CPU   Memory   Sessions

*** Test Cases ***
863361
    [Documentation]    
    [Tags]    v6.0    chrome   863361    Medium    win10,64bit    runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    login FortiGate   username=863361  password=123
    sleep  2
    go to dashboard
    go to dashboard_main
    sleep  2
    check if the widget is reset to default    @{list_defult}        
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate  username=863361
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}

   
